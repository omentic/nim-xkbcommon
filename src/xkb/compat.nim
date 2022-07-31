##
##  Copyright © 2012 Daniel Stone
##
##  Permission is hereby granted, free of charge, to any person obtaining a
##  copy of this software and associated documentation files (the "Software"),
##  to deal in the Software without restriction, including without limitation
##  the rights to use, copy, modify, merge, publish, distribute, sublicense,
##  and/or sell copies of the Software, and to permit persons to whom the
##  Software is furnished to do so, subject to the following conditions:
##
##  The above copyright notice and this permission notice (including the next
##  paragraph) shall be included in all copies or substantial portions of the
##  Software.
##
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
##  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
##  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
##  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
##  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
##  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
##  DEALINGS IN THE SOFTWARE.
##
##  Author: Daniel Stone <daniel@fooishbar.org>
##

##  Renamed keymap API.

const
  XkbGroupIndex* = XkbLayoutIndex
  XkbGroupMask* = XkbLayoutMask
  XkbMapCompileFlags* = XkbKeymapCompileFlags
  XKB_GROUP_INVALID* = XKB_LAYOUT_INVALID
  XKB_STATE_DEPRESSED* = (XKB_STATE_MODS_DEPRESSED or XKB_STATE_LAYOUT_DEPRESSED)
  XKB_STATE_LATCHED* = (XKB_STATE_MODS_LATCHED or XKB_STATE_LAYOUT_LATCHED)
  XKB_STATE_LOCKED* = (XKB_STATE_MODS_LOCKED or XKB_STATE_LAYOUT_LOCKED)
  XKB_STATE_EFFECTIVE* = (XKB_STATE_DEPRESSED or XKB_STATE_LATCHED or
      XKB_STATE_LOCKED or XKB_STATE_MODS_EFFECTIVE or XKB_STATE_LAYOUT_EFFECTIVE)

template xkb_map_new_from_names*(context, names, flags: untyped): untyped =
  xkb_keymap_new_from_names(context, names, flags)

template xkb_map_new_from_file*(context, file, format, flags: untyped): untyped =
  xkb_keymap_new_from_file(context, file, format, flags)

template xkb_map_new_from_string*(context, string, format, flags: untyped): untyped =
  xkb_keymap_new_from_string(context, string, format, flags)

template xkb_map_get_as_string*(keymap: untyped): untyped =
  xkb_keymap_get_as_string(keymap, XKB_KEYMAP_FORMAT_TEXT_V1)

template xkb_map_ref*(keymap: untyped): untyped =
  xkb_keymap_ref(keymap)

template xkb_map_unref*(keymap: untyped): untyped =
  xkb_keymap_unref(keymap)

template xkb_map_num_mods*(keymap: untyped): untyped =
  xkb_keymap_num_mods(keymap)

template xkb_map_mod_get_name*(keymap, idx: untyped): untyped =
  xkb_keymap_mod_get_name(keymap, idx)

template xkb_map_mod_get_index*(keymap, str: untyped): untyped =
  xkb_keymap_mod_get_index(keymap, str)

template xkb_key_mod_index_is_consumed*(state, key, `mod`: untyped): untyped =
  xkb_state_mod_index_is_consumed(state, key, `mod`)

template xkb_key_mod_mask_remove_consumed*(state, key, modmask: untyped): untyped =
  xkb_state_mod_mask_remove_consumed(state, key, modmask)

template xkb_map_num_groups*(keymap: untyped): untyped =
  xkb_keymap_num_layouts(keymap)

template xkb_key_num_groups*(keymap, key: untyped): untyped =
  xkb_keymap_num_layouts_for_key(keymap, key)

template xkb_map_group_get_name*(keymap, idx: untyped): untyped =
  xkb_keymap_layout_get_name(keymap, idx)

template xkb_map_group_get_index*(keymap, str: untyped): untyped =
  xkb_keymap_layout_get_index(keymap, str)

template xkb_map_num_leds*(keymap: untyped): untyped =
  xkb_keymap_num_leds(keymap)

template xkb_map_led_get_name*(keymap, idx: untyped): untyped =
  xkb_keymap_led_get_name(keymap, idx)

template xkb_map_led_get_index*(keymap, str: untyped): untyped =
  xkb_keymap_led_get_index(keymap, str)

template xkb_key_repeats*(keymap, key: untyped): untyped =
  xkb_keymap_key_repeats(keymap, key)

template xkb_key_get_syms*(state, key, syms_out: untyped): untyped =
  xkb_state_key_get_syms(state, key, syms_out)

template xkb_state_group_name_is_active*(state, name, `type`: untyped): untyped =
  xkb_state_layout_name_is_active(state, name, `type`)

template xkb_state_group_index_is_active*(state, idx, `type`: untyped): untyped =
  xkb_state_layout_index_is_active(state, idx, `type`)

template xkb_state_serialize_group*(state, component: untyped): untyped =
  xkb_state_serialize_layout(state, component)

template xkb_state_get_map*(state: untyped): untyped =
  xkb_state_get_keymap(state)

##  Not needed anymore, since there's NO_FLAGS.

const
  XKB_MAP_COMPILE_PLACEHOLDER* = XKB_KEYMAP_COMPILE_NO_FLAGS
  XKB_MAP_COMPILE_NO_FLAGS* = XKB_KEYMAP_COMPILE_NO_FLAGS
