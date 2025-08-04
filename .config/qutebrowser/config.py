c.auto_save.session = True
config.load_autoconfig(False)

c.url.default_page = 'about:blank'
c.qt.workarounds.disable_hangouts_extension = True
c.search.wrap = False
c.downloads.location.prompt = False
c.downloads.position = 'bottom'
c.url.yank_ignored_parameters = ['ref', 'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content', 'utm_name']
c.editor.command = ['alacritty', '-e', 'vim', '-f', '{file}', '-c', 'normal {line}G{column0}l']

# c.completion.show = 'always'
c.completion.show = 'auto'
c.completion.cmd_history_max_items = 100
c.completion.web_history.max_items = -1
c.completion.shrink = True

c.content.autoplay = False
c.content.headers.do_not_track = True
c.content.cookies.accept = 'no-3rdparty'
c.content.blocking.enabled = True
c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt']
c.content.pdfjs = True
c.content.prefers_reduced_motion = True

config.source('gruvbox.py')

c.fonts.web.family.sans_serif = 'JetBrains Mono'
c.fonts.web.size.default = 16
c.fonts.tabs.selected = '12pt default_family'
c.fonts.tabs.unselected = '12pt default_family'
c.fonts.statusbar = '12pt default_family'
c.tabs.padding = {'top': 4, 'bottom': 4, 'left': 5, 'right': 5}
c.statusbar.padding = {'top': 4, 'bottom': 4, 'left': 5, 'right': 5}
c.statusbar.widgets = ['keypress', 'search_match', 'url', 'scroll', 'progress']

config.bind('t', 'cmd-set-text -s :open -t')
config.bind('yob', 'config-cycle colors.webpage.darkmode.enabled on off')

## Which algorithm to use for modifying how colors are rendered with dark
## mode. The `lightness-cielab` value was added with QtWebEngine 5.14 and
## is treated like `lightness-hsl` with older QtWebEngine versions.
## Type: String
## Valid values:
##   - lightness-cielab: Modify colors by converting them to CIELAB color space and inverting the L value. Not available with Qt < 5.14.
##   - lightness-hsl: Modify colors by converting them to the HSL color space and inverting the lightness (i.e. the "L" in HSL).
##   - brightness-rgb: Modify colors by subtracting each of r, g, and b from their maximum value.
# c.colors.webpage.darkmode.algorithm = 'lightness-cielab'

## Contrast for dark mode. This only has an effect when
## `colors.webpage.darkmode.algorithm` is set to `lightness-hsl` or
## `brightness-rgb`.
## Type: Float
# c.colors.webpage.darkmode.contrast = 0.0

## Which pages to apply dark mode to. The underlying Chromium setting has
## been removed in QtWebEngine 5.15.3, thus this setting is ignored
## there. Instead, every element is now classified individually.
## Type: String
## Valid values:
##   - always: Apply dark mode filter to all frames, regardless of content.
##   - smart: Apply dark mode filter to frames based on background color.
# c.colors.webpage.darkmode.policy.page = 'smart'

## Threshold for inverting background elements with dark mode. Background
## elements with brightness above this threshold will be inverted, and
## below it will be left as in the original, non-dark-mode page. Set to
## 256 to never invert the color or to 0 to always invert it. Note: This
## behavior is the opposite of
## `colors.webpage.darkmode.threshold.foreground`!
## Type: Int
# c.colors.webpage.darkmode.threshold.background = 0

## Threshold for inverting text with dark mode. Text colors with
## brightness below this threshold will be inverted, and above it will be
## left as in the original, non-dark-mode page. Set to 256 to always
## invert text color or to 0 to never invert text color.
## Type: Int
# c.colors.webpage.darkmode.threshold.foreground = 256

## When a hint can be automatically followed without pressing Enter.
## Type: String
## Valid values:
##   - always: Auto-follow whenever there is only a single hint on a page.
##   - unique-match: Auto-follow whenever there is a unique non-empty match in either the hint string (word mode) or filter (number mode).
##   - full-match: Follow the hint when the user typed the whole hint (letter, word or number mode) or the element's text (only in number mode).
##   - never: The user will always need to press Enter to follow a hint.
# c.hints.auto_follow = 'unique-match'

## Characters used for hint strings.
## Type: UniqueCharString
# c.hints.chars = 'asdfghjkl'

## Dictionary file to be used by the word hints.
## Type: File
# c.hints.dictionary = '/usr/share/dict/words'

## Hide unmatched hints in rapid mode.
## Type: Bool
# c.hints.hide_unmatched_rapid_hints = True

## Mode to use for hints.
## Type: String
## Valid values:
##   - number: Use numeric hints. (In this mode you can also type letters from the hinted element to filter and reduce the number of elements that are hinted.)
##   - letter: Use the characters in the `hints.chars` setting.
##   - word: Use hints words based on the html elements and the extra words.
# c.hints.mode = 'letter'
