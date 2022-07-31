# I've removed all comments. No way am I dealing with a 2000-line file.

{.push dynlib: "libxkbcommon.so".}

import xkb/[names, keysyms]

discard "forward decl of xkb_context"
discard "forward decl of xkb_keymap"
discard "forward decl of xkb_state"

type
  xkb_keycode_t* = uint32_t
  xkb_keysym_t* = uint32_t
  xkb_layout_index_t* = uint32_t
  xkb_layout_mask_t* = uint32_t
  xkb_level_index_t* = uint32_t
  xkb_mod_index_t* = uint32_t
  xkb_mod_mask_t* = uint32_t
  xkb_led_index_t* = uint32_t
  xkb_led_mask_t* = uint32_t

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

type xkb_rule_names* {.bycopy.} = object
  rules*: cstring
  model*: cstring
  layout*: cstring
  variant*: cstring
  options*: cstring

proc xkb_keysym_get_name*(keysym: xkb_keysym_t; buffer: cstring; size: csize_t): cint {.importc: "xkb_keysym_get_name".}

type xkb_keysym_flags* = enum
  XKB_KEYSYM_NO_FLAGS = 0,
  XKB_KEYSYM_CASE_INSENSITIVE = (1 shl 0)

proc xkb_keysym_from_name*(name: cstring; flags: xkb_keysym_flags): xkb_keysym_t {.importc: "xkb_keysym_from_name".}
proc xkb_keysym_to_utf8*(keysym: xkb_keysym_t; buffer: cstring; size: csize_t): cint {.importc: "xkb_keysym_to_utf8".}
proc xkb_keysym_to_utf32*(keysym: xkb_keysym_t): uint32_t {.importc: "xkb_keysym_to_utf32".}
proc xkb_utf32_to_keysym*(ucs: uint32_t): xkb_keysym_t {.importc: "xkb_utf32_to_keysym".}
proc xkb_keysym_to_upper*(ks: xkb_keysym_t): xkb_keysym_t {.importc: "xkb_keysym_to_upper".}
proc xkb_keysym_to_lower*(ks: xkb_keysym_t): xkb_keysym_t {.importc: "xkb_keysym_to_lower".}

type xkb_context_flags* = enum
  XKB_CONTEXT_NO_FLAGS = 0,
  XKB_CONTEXT_NO_DEFAULT_INCLUDES = (1 shl 0),
  XKB_CONTEXT_NO_ENVIRONMENT_NAMES = (1 shl 1)

proc xkb_context_new*(flags: xkb_context_flags): ptr xkb_context {.importc: "xkb_context_new".}
proc xkb_context_ref*(context: ptr xkb_context): ptr xkb_context {.importc: "xkb_context_ref".}
proc xkb_context_unref*(context: ptr xkb_context) {.importc: "xkb_context_unref".}
proc xkb_context_set_user_data*(context: ptr xkb_context; user_data: pointer) {.importc: "xkb_context_set_user_data".}
proc xkb_context_get_user_data*(context: ptr xkb_context): pointer {.importc: "xkb_context_get_user_data".}

proc xkb_context_include_path_append*(context: ptr xkb_context; path: cstring): cint {.importc: "xkb_context_include_path_append".}
proc xkb_context_include_path_append_default*(context: ptr xkb_context): cint {.importc: "xkb_context_include_path_append_default".}
proc xkb_context_include_path_reset_defaults*(context: ptr xkb_context): cint {.importc: "xkb_context_include_path_reset_defaults".}
proc xkb_context_include_path_clear*(context: ptr xkb_context) {.importc: "xkb_context_include_path_clear".}
proc xkb_context_num_include_paths*(context: ptr xkb_context): cuint {.importc: "xkb_context_num_include_paths".}
proc xkb_context_include_path_get*(context: ptr xkb_context; index: cuint): cstring {.importc: "xkb_context_include_path_get".}

type xkb_log_level* = enum
  XKB_LOG_LEVEL_CRITICAL = 10,
  XKB_LOG_LEVEL_ERROR = 20,
  XKB_LOG_LEVEL_WARNING = 30,
  XKB_LOG_LEVEL_INFO = 40,
  XKB_LOG_LEVEL_DEBUG = 50

proc xkb_context_set_log_level*(context: ptr xkb_context; level: xkb_log_level) {.importc: "xkb_context_set_log_level".}
proc xkb_context_get_log_level*(context: ptr xkb_context): xkb_log_level {.importc: "xkb_context_get_log_level".}
proc xkb_context_set_log_verbosity*(context: ptr xkb_context; verbosity: cint) {.importc: "xkb_context_set_log_verbosity".}
proc xkb_context_get_log_verbosity*(context: ptr xkb_context): cint {.importc: "xkb_context_get_log_verbosity".}
proc xkb_context_set_log_fn*(context: ptr xkb_context; log_fn: proc(context: ptr xkb_context; level: xkb_log_level; format: cstring; args: va_list)) {.importc: "xkb_context_set_log_fn".}

type xkb_keymap_compile_flags* = enum
  XKB_KEYMAP_COMPILE_NO_FLAGS = 0

proc xkb_keymap_new_from_names*(context: ptr xkb_context; names: ptr xkb_rule_names; flags: xkb_keymap_compile_flags): ptr xkb_keymap {.importc: "xkb_keymap_new_from_names".}

type xkb_keymap_format* = enum
  XKB_KEYMAP_FORMAT_TEXT_V1 = 1

proc xkb_keymap_new_from_file*(context: ptr xkb_context; file: ptr FILE; format: xkb_keymap_format; flags: xkb_keymap_compile_flags): ptr xkb_keymap {.importc: "xkb_keymap_new_from_file".}
proc xkb_keymap_new_from_string*(context: ptr xkb_context; string: cstring; format: xkb_keymap_format; flags: xkb_keymap_compile_flags): ptr xkb_keymap {.importc: "xkb_keymap_new_from_string".}
proc xkb_keymap_new_from_buffer*(context: ptr xkb_context; buffer: cstring; length: csize_t; format: xkb_keymap_format; flags: xkb_keymap_compile_flags): ptr xkb_keymap {.importc: "xkb_keymap_new_from_buffer".}

proc xkb_keymap_ref*(keymap: ptr xkb_keymap): ptr xkb_keymap {.importc: "xkb_keymap_ref".}
proc xkb_keymap_unref*(keymap: ptr xkb_keymap) {.importc: "xkb_keymap_unref".}

const XKB_KEYMAP_USE_ORIGINAL_FORMAT* = (cast[xkb_keymap_format](-1))

proc xkb_keymap_get_as_string*(keymap: ptr xkb_keymap; format: xkb_keymap_format): cstring {.importc: "xkb_keymap_get_as_string".}
proc xkb_keymap_min_keycode*(keymap: ptr xkb_keymap): xkb_keycode_t {.importc: "xkb_keymap_min_keycode".}
proc xkb_keymap_max_keycode*(keymap: ptr xkb_keymap): xkb_keycode_t {.importc: "xkb_keymap_max_keycode".}

type xkb_keymap_key_iter_t* = proc(keymap: ptr xkb_keymap; key: xkb_keycode_t; data: pointer)

proc xkb_keymap_key_for_each*(keymap: ptr xkb_keymap; iter: xkb_keymap_key_iter_t; data: pointer) {.importc: "xkb_keymap_key_for_each".}
proc xkb_keymap_key_get_name*(keymap: ptr xkb_keymap; key: xkb_keycode_t): cstring {.importc: "xkb_keymap_key_get_name".}
proc xkb_keymap_key_by_name*(keymap: ptr xkb_keymap; name: cstring): xkb_keycode_t {.importc: "xkb_keymap_key_by_name".}

proc xkb_keymap_num_mods*(keymap: ptr xkb_keymap): xkb_mod_index_t {.importc: "xkb_keymap_num_mods".}
proc xkb_keymap_mod_get_name*(keymap: ptr xkb_keymap; idx: xkb_mod_index_t): cstring {.importc: "xkb_keymap_mod_get_name".}
proc xkb_keymap_mod_get_index*(keymap: ptr xkb_keymap; name: cstring): xkb_mod_index_t {.importc: "xkb_keymap_mod_get_index".}

proc xkb_keymap_num_layouts*(keymap: ptr xkb_keymap): xkb_layout_index_t {.importc: "xkb_keymap_num_layouts".}
proc xkb_keymap_layout_get_name*(keymap: ptr xkb_keymap; idx: xkb_layout_index_t): cstring {.importc: "xkb_keymap_layout_get_name".}
proc xkb_keymap_layout_get_index*(keymap: ptr xkb_keymap; name: cstring): xkb_layout_index_t {.importc: "xkb_keymap_layout_get_index".}

proc xkb_keymap_num_leds*(keymap: ptr xkb_keymap): xkb_led_index_t {.importc: "xkb_keymap_num_leds".}
proc xkb_keymap_led_get_name*(keymap: ptr xkb_keymap; idx: xkb_led_index_t): cstring {.importc: "xkb_keymap_led_get_name".}
proc xkb_keymap_led_get_index*(keymap: ptr xkb_keymap; name: cstring): xkb_led_index_t {.importc: "xkb_keymap_led_get_index".}

proc xkb_keymap_num_layouts_for_key*(keymap: ptr xkb_keymap; key: xkb_keycode_t): xkb_layout_index_t {.importc: "xkb_keymap_num_layouts_for_key".}
proc xkb_keymap_num_levels_for_key*(keymap: ptr xkb_keymap; key: xkb_keycode_t; layout: xkb_layout_index_t): xkb_level_index_t {.importc: "xkb_keymap_num_levels_for_key".}

proc xkb_keymap_key_get_mods_for_level*(keymap: ptr xkb_keymap; key: xkb_keycode_t; layout: xkb_layout_index_t; level: xkb_level_index_t; masks_out: ptr xkb_mod_mask_t; masks_size: csize_t): csize_t {.importc: "xkb_keymap_key_get_mods_for_level".}
proc xkb_keymap_key_get_syms_by_level*(keymap: ptr xkb_keymap; key: xkb_keycode_t; layout: xkb_layout_index_t; level: xkb_level_index_t; syms_out: ptr ptr xkb_keysym_t): cint {.importc: "xkb_keymap_key_get_syms_by_level".}
proc xkb_keymap_key_repeats*(keymap: ptr xkb_keymap; key: xkb_keycode_t): cint {.importc: "xkb_keymap_key_repeats".}

proc xkb_state_new*(keymap: ptr xkb_keymap): ptr xkb_state {.importc: "xkb_state_new".}
proc xkb_state_ref*(state: ptr xkb_state): ptr xkb_state {.importc: "xkb_state_ref".}
proc xkb_state_unref*(state: ptr xkb_state) {.importc: "xkb_state_unref".}
proc xkb_state_get_keymap*(state: ptr xkb_state): ptr xkb_keymap {.importc: "xkb_state_get_keymap".}

type xkb_key_direction* = enum
  XKB_KEY_UP,
  XKB_KEY_DOWN

type xkb_state_component* = enum
  XKB_STATE_MODS_DEPRESSED = (1 shl 0),
  XKB_STATE_MODS_LATCHED = (1 shl 1),
  XKB_STATE_MODS_LOCKED = (1 shl 2),
  XKB_STATE_MODS_EFFECTIVE = (1 shl 3),
  XKB_STATE_LAYOUT_DEPRESSED = (1 shl 4),
  XKB_STATE_LAYOUT_LATCHED = (1 shl 5),
  XKB_STATE_LAYOUT_LOCKED = (1 shl 6),
  XKB_STATE_LAYOUT_EFFECTIVE = (1 shl 7),
  XKB_STATE_LEDS = (1 shl 8)

proc xkb_state_update_key*(state: ptr xkb_state; key: xkb_keycode_t; direction: xkb_key_direction): xkb_state_component {.importc: "xkb_state_update_key".}
proc xkb_state_update_mask*(state: ptr xkb_state; depressed_mods: xkb_mod_mask_t; latched_mods: xkb_mod_mask_t; locked_mods: xkb_mod_mask_t; depressed_layout: xkb_layout_index_t; latched_layout: xkb_layout_index_t; locked_layout: xkb_layout_index_t): xkb_state_component {.importc: "xkb_state_update_mask".}

proc xkb_state_key_get_syms*(state: ptr xkb_state; key: xkb_keycode_t; syms_out: ptr ptr xkb_keysym_t): cint {.importc: "xkb_state_key_get_syms".}
proc xkb_state_key_get_utf8*(state: ptr xkb_state; key: xkb_keycode_t; buffer: cstring; size: csize_t): cint {.importc: "xkb_state_key_get_utf8".}
proc xkb_state_key_get_utf32*(state: ptr xkb_state; key: xkb_keycode_t): uint32_t {.importc: "xkb_state_key_get_utf32".}
proc xkb_state_key_get_one_sym*(state: ptr xkb_state; key: xkb_keycode_t): xkb_keysym_t {.importc: "xkb_state_key_get_one_sym".}
proc xkb_state_key_get_layout*(state: ptr xkb_state; key: xkb_keycode_t): xkb_layout_index_t {.importc: "xkb_state_key_get_layout".}
proc xkb_state_key_get_level*(state: ptr xkb_state; key: xkb_keycode_t; layout: xkb_layout_index_t): xkb_level_index_t {.importc: "xkb_state_key_get_level".}

type xkb_state_match* = enum
  XKB_STATE_MATCH_ANY = (1 shl 0),
  XKB_STATE_MATCH_ALL = (1 shl 1),
  XKB_STATE_MATCH_NON_EXCLUSIVE = (1 shl 16)

proc xkb_state_serialize_mods*(state: ptr xkb_state; components: xkb_state_component): xkb_mod_mask_t {.importc: "xkb_state_serialize_mods".}
proc xkb_state_serialize_layout*(state: ptr xkb_state; components: xkb_state_component): xkb_layout_index_t {.importc: "xkb_state_serialize_layout".}

proc xkb_state_mod_name_is_active*(state: ptr xkb_state; name: cstring; `type`: xkb_state_component): cint {.importc: "xkb_state_mod_name_is_active".}
proc xkb_state_mod_names_are_active*(state: ptr xkb_state; `type`: xkb_state_component; match: xkb_state_match): cint {.varargs.} {.importc: "xkb_state_mod_names_are_active".}
proc xkb_state_mod_index_is_active*(state: ptr xkb_state; idx: xkb_mod_index_t; `type`: xkb_state_component): cint {.importc: "xkb_state_mod_index_is_active".}
proc xkb_state_mod_indices_are_active*(state: ptr xkb_state; `type`: xkb_state_component; match: xkb_state_match): cint {.varargs.} {.importc: "xkb_state_mod_indices_are_active".}

type xkb_consumed_mode* = enum
  XKB_CONSUMED_MODE_XKB,
  XKB_CONSUMED_MODE_GTK

proc xkb_state_key_get_consumed_mods2*(state: ptr xkb_state; key: xkb_keycode_t; mode: xkb_consumed_mode): xkb_mod_mask_t {.importc: "xkb_state_key_get_consumed_mods2".}
proc xkb_state_key_get_consumed_mods*(state: ptr xkb_state; key: xkb_keycode_t): xkb_mod_mask_t {.importc: "xkb_state_key_get_consumed_mods".}

proc xkb_state_mod_index_is_consumed2*(state: ptr xkb_state; key: xkb_keycode_t; idx: xkb_mod_index_t; mode: xkb_consumed_mode): cint {.importc: "xkb_state_mod_index_is_consumed2".}
proc xkb_state_mod_index_is_consumed*(state: ptr xkb_state; key: xkb_keycode_t; idx: xkb_mod_index_t): cint {.importc: "xkb_state_mod_index_is_consumed".}
proc xkb_state_mod_mask_remove_consumed*(state: ptr xkb_state; key: xkb_keycode_t; mask: xkb_mod_mask_t): xkb_mod_mask_t {.importc: "xkb_state_mod_mask_remove_consumed".}

proc xkb_state_layout_name_is_active*(state: ptr xkb_state; name: cstring; `type`: xkb_state_component): cint {.importc: "xkb_state_layout_name_is_active".}
proc xkb_state_layout_index_is_active*(state: ptr xkb_state; idx: xkb_layout_index_t; `type`: xkb_state_component): cint {.importc: "xkb_state_layout_index_is_active".}

proc xkb_state_led_name_is_active*(state: ptr xkb_state; name: cstring): cint {.importc: "xkb_state_led_name_is_active".}
proc xkb_state_led_index_is_active*(state: ptr xkb_state; idx: xkb_led_index_t): cint {.importc: "xkb_state_led_index_is_active".}

{.pop.}
