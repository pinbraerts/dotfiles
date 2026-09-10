import { closeSync, openSync, writeSync } from "node:fs";
import { basename } from "node:path";

const NOTIFICATION_DEBOUNCE_MS = 1500;
const recentNotifications = new Map();

function eventProperties(event) {
  // OpenCode 1.x exposes `properties`; newer event envelopes use `data`.
  return event?.properties || event?.data || {};
}

function clean(value, fallback) {
  const text = String(value || fallback)
    .replace(/[\x00-\x1f\x7f;]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
  return text.slice(0, 180);
}

function notificationSequence(title, body) {
  const osc = `\x1b]777;notify;${clean(title, "OpenCode")};${clean(body, "Ready")}\x07`;
  // Inside tmux, BEL is the common attention signal. tmux keeps its native
  // window marker and its alert-bell hook emits the desktop notification.
  return process.env.TMUX ? "\x07" : osc;
}

function notify(title, body) {
  try {
    const tty = openSync("/dev/tty", "w");
    try {
      writeSync(tty, notificationSequence(title, body));
    } finally {
      closeSync(tty);
    }
  } catch {
    // Notifications are optional and must never interrupt an OpenCode session.
  }
}

function shouldNotify(key) {
  const now = Date.now();
  const previous = recentNotifications.get(key) || 0;
  recentNotifications.set(key, now);
  return now - previous >= NOTIFICATION_DEBOUNCE_MS;
}

function questionSummary(properties) {
  const question = properties.questions?.[0];
  return question?.question || question?.header || "OpenCode has a question";
}

export default {
  id: "desktop-notifications",

  async server(input) {
    const childSessions = new Set();
    const projectName = basename(input.worktree || input.directory || "OpenCode");

    return {
      async event({ event }) {
        if (!event?.type) return;

        const properties = eventProperties(event);
        const info = properties.info || {};
        const sessionID = properties.sessionID || info.sessionID || info.id || "unknown";

        if (event.type === "session.created" || event.type === "session.updated") {
          if (info.parentID) childSessions.add(info.id);
          else childSessions.delete(info.id);
          return;
        }
        if (event.type === "session.deleted") {
          childSessions.delete(sessionID);
          return;
        }
        if (childSessions.has(sessionID)) return;

        if (event.type === "permission.asked" || event.type === "permission.v2.asked") {
          const permission = properties.permission || properties.title || "permission";
          const key = `${sessionID}:permission:${properties.id || permission}`;
          if (shouldNotify(key)) notify("OpenCode needs permission", `${projectName}: ${permission}`);
          return;
        }

        if (event.type === "question.asked" || event.type === "question.v2.asked") {
          const key = `${sessionID}:question:${properties.id || questionSummary(properties)}`;
          if (shouldNotify(key)) notify("OpenCode needs input", questionSummary(properties));
          return;
        }

        if (event.type === "session.idle") {
          const key = `${sessionID}:idle`;
          if (shouldNotify(key)) notify("OpenCode is ready", `${projectName}: waiting for your prompt`);
        }
      },
    };
  },
};
