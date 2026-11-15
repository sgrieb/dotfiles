import type { Register } from 'claude-code'

/**
 * As little text around the prompt as the engine lets a mod take away. Only the permission
 * mode ("⏵⏵ bypass permissions on") is left, since a mod cannot reach it.
 */
export const register: Register = (on) => {
  // The hint line under the prompt ("(shift+tab to cycle)", "esc to interrupt", "? for
  // shortcuts"): empty.
  on('ui.render', { component: 'PromptHint' }, ($, e, next) =>
    next({ ...e, props: { ...e.props, hint: '' } }),
  )

  // The dim mode labels at the right of the footer ("focus", "memory paused"): none.
  on('ui.render', { component: 'SessionMode' }, ($, e, next) =>
    next({ ...e, props: { ...e.props, modes: [] } }),
  )

  // The line that animates while a turn runs ("Perusing… (23s · 2.5k tokens · thinking)"):
  // nothing is drawn in its place.
  on('ui.render', { component: 'Spinner' }, ($, e) => {
    const { Box } = $.ui.resolve(e)
    return Box({})
  })
}
