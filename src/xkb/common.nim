# I've removed all comments. No way am I dealing with a 2000-line file.

{.push dynlib: "libxkbcommon.so".}

import names, keysyms

type
  XkbContext* = object
  XkbKeymap* = object
  XkbState* = object

type
  XkbKeycode* = uint32
  XkbKeysym* = uint32
  XkbLayoutIndex* = uint32
  XkbLayoutMask* = uint32
  XkbLevelIndex* = uint32
  XkbModIndex* = uint32
  XkbModMask* = uint32
  XkbLedIndex* = uint32
  XkbLedMask* = uint32

const
  XKB_KEYCODE_INVALID* = (0xffffffff)
  XKB_LAYOUT_INVALID* = (0xffffffff)
  XKB_LEVEL_INVALID* = (0xffffffff)
  XKB_MOD_INVALID* = (0xffffffff)
  XKB_LED_INVALID* = (0xffffffff)
  XKB_KEYCODE_MAX* = (0xffffffff - 1)

template xkb_keycode_is_legal_ext*(key: untyped): untyped =
  (key <= XKB_KEYCODE_MAX)
template xkb_keycode_is_legal_x11*(key: untyped): untyped =
  (key >= 8 and key <= 255)

type XkbRuleNames* {.bycopy.} = object
  rules*: cstring
  model*: cstring
  layout*: cstring
  variant*: cstring
  options*: cstring

proc get_name*(keysym: XkbKeysym; buffer: cstring; size: csize_t): cint {.importc: "xkb_keysym_get_name".}

type XkbKeysymFlags* {.pure.} = enum
  NO_FLAGS = 0,
  CASE_INSENSITIVE = (1 shl 0)

proc xkb_keysym_from_name*(name: cstring; flags: XkbKeysymFlags): XkbKeysym {.importc: "xkb_keysym_from_name".}
proc to_utf8*(keysym: XkbKeysym; buffer: cstring; size: csize_t): cint {.importc: "xkb_keysym_to_utf8".}
proc to_utf32*(keysym: XkbKeysym): uint32 {.importc: "xkb_keysym_to_utf32".}
proc to_keysym*(ucs: uint32): XkbKeysym {.importc: "xkb_utf32_to_keysym".}
proc to_upper*(ks: XkbKeysym): XkbKeysym {.importc: "xkb_keysym_to_upper".}
proc to_lower*(ks: XkbKeysym): XkbKeysym {.importc: "xkb_keysym_to_lower".}

type XkbContextFlags* {.pure.} = enum
  NO_FLAGS = 0,
  NO_DEFAULT_INCLUDES = (1 shl 0),
  NO_ENVIRONMENT_NAMES = (1 shl 1)

proc new_xkb_context*(flags: XkbContextFlags): ptr XkbContext {.importc: "xkb_context_new".}
proc `ref`*(context: ptr XkbContext): ptr XkbContext {.importc: "xkb_context_ref".}
proc unref*(context: ptr XkbContext) {.importc: "xkb_context_unref".}
proc set_user_data*(context: ptr XkbContext; user_data: pointer) {.importc: "xkb_context_set_user_data".}
proc get_user_data*(context: ptr XkbContext): pointer {.importc: "xkb_context_get_user_data".}

proc include_path_append*(context: ptr XkbContext; path: cstring): cint {.importc: "xkb_context_include_path_append".}
proc include_path_append_default*(context: ptr XkbContext): cint {.importc: "xkb_context_include_path_append_default".}
proc include_path_reset_defaults*(context: ptr XkbContext): cint {.importc: "xkb_context_include_path_reset_defaults".}
proc include_path_clear*(context: ptr XkbContext) {.importc: "xkb_context_include_path_clear".}
proc num_include_paths*(context: ptr XkbContext): cuint {.importc: "xkb_context_num_include_paths".}
proc include_path_get*(context: ptr XkbContext; index: cuint): cstring {.importc: "xkb_context_include_path_get".}

type XkbLogLevel* {.pure.} = enum
  CRITICAL = 10,
  ERROR = 20,
  WARNING = 30,
  INFO = 40,
  DEBUG = 50

proc set_log_level*(context: ptr XkbContext; level: XkbLogLevel) {.importc: "xkb_context_set_log_level".}
proc get_log_level*(context: ptr XkbContext): XkbLogLevel {.importc: "xkb_context_get_log_level".}
proc set_log_verbosity*(context: ptr XkbContext; verbosity: cint) {.importc: "xkb_context_set_log_verbosity".}
proc get_log_verbosity*(context: ptr XkbContext): cint {.importc: "xkb_context_get_log_verbosity".}

type va_list {.importc: "va_list", header: "<stdarg.h>".} = object

proc set_log_fn*(context: ptr XkbContext; log_fn: proc(context: ptr XkbContext; level: XkbLogLevel; format: cstring; args: va_list)) {.importc: "xkb_context_set_log_fn".}

type XkbKeymapCompileFlags* {.pure.} = enum
  NO_FLAGS = 0

proc new_from_names_xkb_keymap*(context: ptr XkbContext; names: ptr XkbRuleNames; flags: XkbKeymapCompileFlags): ptr XkbKeymap {.importc: "xkb_keymap_new_from_names".}

type XkbKeymapFormat* {.pure.} = enum
  TEXT_V1 = 1

proc new_from_file_xkb_keymap*(context: ptr XkbContext; file: ptr FILE; format: XkbKeymapFormat; flags: XkbKeymapCompileFlags): ptr XkbKeymap {.importc: "xkb_keymap_new_from_file".}
proc new_from_string_xkb_keymap*(context: ptr XkbContext; string: cstring; format: XkbKeymapFormat; flags: XkbKeymapCompileFlags): ptr XkbKeymap {.importc: "xkb_keymap_new_from_string".}
proc new_from_buffer_xkb_keymap*(context: ptr XkbContext; buffer: cstring; length: csize_t; format: XkbKeymapFormat; flags: XkbKeymapCompileFlags): ptr XkbKeymap {.importc: "xkb_keymap_new_from_buffer".}

proc `ref`*(keymap: ptr XkbKeymap): ptr XkbKeymap {.importc: "xkb_keymap_ref".}
proc unref*(keymap: ptr XkbKeymap) {.importc: "xkb_keymap_unref".}

# const XKB_KEYMAP_USE_ORIGINAL_FORMAT* = (cast[XkbKeymapFormat](-1))

proc get_as_string*(keymap: ptr XkbKeymap; format: XkbKeymapFormat): cstring {.importc: "xkb_keymap_get_as_string".}
proc min_keycode*(keymap: ptr XkbKeymap): XkbKeycode {.importc: "xkb_keymap_min_keycode".}
proc max_keycode*(keymap: ptr XkbKeymap): XkbKeycode {.importc: "xkb_keymap_max_keycode".}

type XkbKeymapKeyIter* = proc(keymap: ptr XkbKeymap; key: XkbKeycode; data: pointer)

proc for_each*(keymap: ptr XkbKeymap; iter: XkbKeymapKeyIter; data: pointer) {.importc: "xkb_keymap_key_for_each".}
proc get_name*(keymap: ptr XkbKeymap; key: XkbKeycode): cstring {.importc: "xkb_keymap_key_get_name".}
proc by_name*(keymap: ptr XkbKeymap; name: cstring): XkbKeycode {.importc: "xkb_keymap_key_by_name".}

proc num_mods*(keymap: ptr XkbKeymap): XkbModIndex {.importc: "xkb_keymap_num_mods".}
proc mod_get_name*(keymap: ptr XkbKeymap; idx: XkbModIndex): cstring {.importc: "xkb_keymap_mod_get_name".}
proc mod_get_index*(keymap: ptr XkbKeymap; name: cstring): XkbModIndex {.importc: "xkb_keymap_mod_get_index".}

proc num_layouts*(keymap: ptr XkbKeymap): XkbLayoutIndex {.importc: "xkb_keymap_num_layouts".}
proc layout_get_name*(keymap: ptr XkbKeymap; idx: XkbLayoutIndex): cstring {.importc: "xkb_keymap_layout_get_name".}
proc layout_get_index*(keymap: ptr XkbKeymap; name: cstring): XkbLayoutIndex {.importc: "xkb_keymap_layout_get_index".}

proc num_leds*(keymap: ptr XkbKeymap): XkbLedIndex {.importc: "xkb_keymap_num_leds".}
proc led_get_name*(keymap: ptr XkbKeymap; idx: XkbLedIndex): cstring {.importc: "xkb_keymap_led_get_name".}
proc led_get_index*(keymap: ptr XkbKeymap; name: cstring): XkbLedIndex {.importc: "xkb_keymap_led_get_index".}

proc num_layouts*(keymap: ptr XkbKeymap; key: XkbKeycode): XkbLayoutIndex {.importc: "xkb_keymap_num_layouts_for_key".}
proc num_levels*(keymap: ptr XkbKeymap; key: XkbKeycode; layout: XkbLayoutIndex): XkbLevelIndex {.importc: "xkb_keymap_num_levels_for_key".}

proc get_mods*(keymap: ptr XkbKeymap; key: XkbKeycode; layout: XkbLayoutIndex; level: XkbLevelIndex; masks_out: ptr XkbModMask; masks_size: csize_t): csize_t {.importc: "xkb_keymap_key_get_mods_for_level".}
proc get_syms*(keymap: ptr XkbKeymap; key: XkbKeycode; layout: XkbLayoutIndex; level: XkbLevelIndex; syms_out: ptr ptr XkbKeysym): cint {.importc: "xkb_keymap_key_get_syms_by_level".}
proc repeats*(keymap: ptr XkbKeymap; key: XkbKeycode): cint {.importc: "xkb_keymap_key_repeats".}

proc new_xkb_state*(keymap: ptr XkbKeymap): ptr XkbState {.importc: "xkb_state_new".}
proc `ref`*(state: ptr XkbState): ptr XkbState {.importc: "xkb_state_ref".}
proc unref*(state: ptr XkbState) {.importc: "xkb_state_unref".}
proc get_keymap*(state: ptr XkbState): ptr XkbKeymap {.importc: "xkb_state_get_keymap".}

type XkbKeyDirection* {.pure.} = enum
  UP, DOWN

type XkbStateComponent* {.pure.} = enum
  MODS_DEPRESSED = (1 shl 0),
  MODS_LATCHED = (1 shl 1),
  MODS_LOCKED = (1 shl 2),
  MODS_EFFECTIVE = (1 shl 3),
  LAYOUT_DEPRESSED = (1 shl 4),
  LAYOUT_LATCHED = (1 shl 5),
  LAYOUT_LOCKED = (1 shl 6),
  LAYOUT_EFFECTIVE = (1 shl 7),
  LEDS = (1 shl 8)

proc update_key*(state: ptr XkbState; key: XkbKeycode; direction: XkbKeyDirection): XkbStateComponent {.importc: "xkb_state_update_key".}
proc update_mask*(state: ptr XkbState; depressed_mods: XkbModMask; latched_mods: XkbModMask; locked_mods: XkbModMask; depressed_layout: XkbLayoutIndex; latched_layout: XkbLayoutIndex; locked_layout: XkbLayoutIndex): XkbStateComponent {.importc: "xkb_state_update_mask".}

proc get_syms*(state: ptr XkbState; key: XkbKeycode; syms_out: ptr ptr XkbKeysym): cint {.importc: "xkb_state_key_get_syms".}
proc get_utf8*(state: ptr XkbState; key: XkbKeycode; buffer: cstring; size: csize_t): cint {.importc: "xkb_state_key_get_utf8".}
proc get_utf32*(state: ptr XkbState; key: XkbKeycode): uint32 {.importc: "xkb_state_key_get_utf32".}
proc get_one_sym*(state: ptr XkbState; key: XkbKeycode): XkbKeysym {.importc: "xkb_state_key_get_one_sym".}
proc get_layout*(state: ptr XkbState; key: XkbKeycode): XkbLayoutIndex {.importc: "xkb_state_key_get_layout".}
proc get_level*(state: ptr XkbState; key: XkbKeycode; layout: XkbLayoutIndex): XkbLevelIndex {.importc: "xkb_state_key_get_level".}

type XkbStateMatch* {.pure.} = enum
  ANY = (1 shl 0),
  ALL = (1 shl 1),
  NON_EXCLUSIVE = (1 shl 16)

proc serialize_mods*(state: ptr XkbState; components: XkbStateComponent): XkbModMask {.importc: "xkb_state_serialize_mods".}
proc serialize_layout*(state: ptr XkbState; components: XkbStateComponent): XkbLayoutIndex {.importc: "xkb_state_serialize_layout".}

proc mod_name_is_active*(state: ptr XkbState; name: cstring; `type`: XkbStateComponent): cint {.importc: "xkb_state_mod_name_is_active".}
proc mod_names_are_active*(state: ptr XkbState; `type`: XkbStateComponent; match: XkbStateMatch): cint {.varargs, importc: "xkb_state_mod_names_are_active".}
proc mod_index_is_active*(state: ptr XkbState; idx: XkbModIndex; `type`: XkbStateComponent): cint {.importc: "xkb_state_mod_index_is_active".}
proc mod_indices_are_active*(state: ptr XkbState; `type`: XkbStateComponent; match: XkbStateMatch): cint {.varargs, importc: "xkb_state_mod_indices_are_active".}

type XkbConsumedMode* {.pure.} = enum
  XKB, GTK

proc get_consumed_mods2*(state: ptr XkbState; key: XkbKeycode; mode: XkbConsumedMode): XkbModMask {.importc: "xkb_state_key_get_consumed_mods2".}
proc get_consumed_mods*(state: ptr XkbState; key: XkbKeycode): XkbModMask {.importc: "xkb_state_key_get_consumed_mods".}

proc mod_index_is_consumed2*(state: ptr XkbState; key: XkbKeycode; idx: XkbModIndex; mode: XkbConsumedMode): cint {.importc: "xkb_state_mod_index_is_consumed2".}
proc mod_index_is_consumed*(state: ptr XkbState; key: XkbKeycode; idx: XkbModIndex): cint {.importc: "xkb_state_mod_index_is_consumed".}
proc mod_mask_remove_consumed*(state: ptr XkbState; key: XkbKeycode; mask: XkbModMask): XkbModMask {.importc: "xkb_state_mod_mask_remove_consumed".}

proc layout_name_is_active*(state: ptr XkbState; name: cstring; `type`: XkbStateComponent): cint {.importc: "xkb_state_layout_name_is_active".}
proc layout_index_is_active*(state: ptr XkbState; idx: XkbLayoutIndex; `type`: XkbStateComponent): cint {.importc: "xkb_state_layout_index_is_active".}

proc led_name_is_active*(state: ptr XkbState; name: cstring): cint {.importc: "xkb_state_led_name_is_active".}
proc led_index_is_active*(state: ptr XkbState; idx: XkbLedIndex): cint {.importc: "xkb_state_led_index_is_active".}

{.pop.}
