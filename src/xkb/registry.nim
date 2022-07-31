# I've removed all comments again for ease of modification.

{.push dynlib: "libxkbcommon.so".}

type
  RXkbContext* = object
  RXkbModel* = object
  RXkbLayout* = object
  RXkbOption* = object
  RXkbOptionGroup* = object
  RXkbIso639Code* = object
  RXkbIso3166Code* = object

type RXkbPopularity* {.pure.} = enum
  STANDARD = 1, EXOTIC

type RXkbContextFlags* {.pure.} = enum
  NO_FLAGS = 0,
  NO_DEFAULT_INCLUDES = (1 shl 0),
  LOAD_EXOTIC_RULES = (1 shl 1)

proc new_rxkb_context*(flags: RXkbContextFlags): ptr RXkbContext {.importc: "rxkb_context_new".}

type RXkbLogLevel* {.pure.} = enum
  CRITICAL = 10,
  ERROR = 20,
  WARNING = 30,
  INFO = 40,
  DEBUG = 50

proc set_log_level*(ctx: ptr RXkbContext; level: RXkbLogLevel) {.importc: "rxkb_context_set_log_level".}
proc get_log_level*(ctx: ptr RXkbContext): RXkbLogLevel {.importc: "rxkb_context_get_log_level".}
proc set_log_fn*(ctx: ptr RXkbContext; log_fn: proc(ctx: ptr RXkbContext; level: RXkbLogLevel; format: cstring; args: va_list)) {.importc: "rxkb_context_set_log_fn".}
proc parse*(ctx: ptr RXkbContext; ruleset: cstring): bool {.importc: "rxkb_context_parse".}
proc parse_default_ruleset*(ctx: ptr RXkbContext): bool {.importc: "rxkb_context_parse_default_ruleset".}
proc ref*(ctx: ptr RXkbContext): ptr RXkbContext {.importc: "rxkb_context_ref".}
proc unref*(ctx: ptr RXkbContext): ptr RXkbContext {.importc: "rxkb_context_unref".}

proc set_user_data*(ctx: ptr RXkbContext; user_data: pointer) {.importc: "rxkb_context_set_user_data".}
proc get_user_data*(ctx: ptr RXkbContext): pointer {.importc: "rxkb_context_get_user_data".}
proc include_path_append*(ctx: ptr RXkbContext; path: cstring): bool {.importc: "rxkb_context_include_path_append".}
proc include_path_append_default*(ctx: ptr RXkbContext): bool {.importc: "rxkb_context_include_path_append_default".}

proc first_rxkb_model*(ctx: ptr RXkbContext): ptr RXkbModel {.importc: "rxkb_model_first".}
proc next*(m: ptr RXkbModel): ptr RXkbModel {.importc: "rxkb_model_next".}
proc ref*(m: ptr RXkbModel): ptr RXkbModel {.importc: "rxkb_model_ref".}
proc unref*(m: ptr RXkbModel): ptr RXkbModel {.importc: "rxkb_model_unref".}

proc get_name*(m: ptr RXkbModel): cstring {.importc: "rxkb_model_get_name".}
proc get_description*(m: ptr RXkbModel): cstring {.importc: "rxkb_model_get_description".}
proc get_vendor*(m: ptr RXkbModel): cstring {.importc: "rxkb_model_get_vendor".}
proc get_popularity*(m: ptr RXkbModel): RXkbPopularity {.importc: "rxkb_model_get_popularity".}

proc first_rxkb_layout*(ctx: ptr RXkbContext): ptr RXkbLayout {.importc: "rxkb_layout_first".}
proc next*(l: ptr RXkbLayout): ptr RXkbLayout {.importc: "rxkb_layout_next".}
proc ref*(l: ptr RXkbLayout): ptr RXkbLayout {.importc: "rxkb_layout_ref".}
proc unref*(l: ptr RXkbLayout): ptr RXkbLayout {.importc: "rxkb_layout_unref".}

proc get_name*(l: ptr RXkbLayout): cstring {.importc: "rxkb_layout_get_name".}
proc get_variant*(l: ptr RXkbLayout): cstring {.importc: "rxkb_layout_get_variant".}
proc get_brief*(l: ptr RXkbLayout): cstring {.importc: "rxkb_layout_get_brief".}
proc get_description*(l: ptr RXkbLayout): cstring {.importc: "rxkb_layout_get_description".}
proc get_popularity*(l: ptr RXkbLayout): RXkbPopularity {.importc: "rxkb_layout_get_popularity".}

proc first_rxkb_option_group*(ctx: ptr RXkbContext): ptr RXkbOptionGroup {.importc: "rxkb_option_group_first".}
proc next*(g: ptr RXkbOptionGroup): ptr RXkbOptionGroup {.importc: "rxkb_option_group_next".}
proc ref*(g: ptr RXkbOptionGroup): ptr RXkbOptionGroup {.importc: "rxkb_option_group_ref".}
proc unref*(g: ptr RXkbOptionGroup): ptr RXkbOptionGroup {.importc: "rxkb_option_group_unref".}

proc get_name*(m: ptr RXkbOptionGroup): cstring {.importc: "rxkb_option_group_get_name".}
proc get_description*(m: ptr RXkbOptionGroup): cstring {.importc: "rxkb_option_group_get_description".}
proc allows_multiple*(g: ptr RXkbOptionGroup): bool {.importc: "rxkb_option_group_allows_multiple".}
proc get_popularity*(g: ptr RXkbOptionGroup): RXkbPopularity {.importc: "rxkb_option_group_get_popularity".}

proc first*(group: ptr RXkbOptionGroup): ptr RXkbOption {.importc: "rxkb_option_first".}
proc next*(o: ptr RXkbOption): ptr RXkbOption {.importc: "rxkb_option_next".}
proc ref*(o: ptr RXkbOption): ptr RXkbOption {.importc: "rxkb_option_ref".}
proc unref*(o: ptr RXkbOption): ptr RXkbOption {.importc: "rxkb_option_unref".}
proc get_name*(o: ptr RXkbOption): cstring {.importc: "rxkb_option_get_name".}
proc get_brief*(o: ptr RXkbOption): cstring {.importc: "rxkb_option_get_brief".}
proc get_description*(o: ptr RXkbOption): cstring {.importc: "rxkb_option_get_description".}
proc get_popularity*(o: ptr RXkbOption): RXkbPopularity {.importc: "rxkb_option_get_popularity".}

proc ref*(iso639: ptr RXkbIso639Code): ptr RXkbIso639Code {.importc: "rxkb_iso639_code_ref".}
proc unref*(iso639: ptr RXkbIso639Code): ptr RXkbIso639Code {.importc: "rxkb_iso639_code_unref".}
proc getCode*(iso639: ptr RXkbIso639Code): cstring {.importc: "rxkb_iso639_code_get_code".}
proc get_iso639_first*(layout: ptr RXkbLayout): ptr RXkbIso639Code {.importc: "rxkb_layout_get_iso639_first".}
proc next*(iso639: ptr RXkbIso639Code): ptr RXkbIso639Code {.importc: "rxkb_iso639_code_next".}

proc ref*(iso3166: ptr RxkbIso3166Code): ptr RxkbIso3166Code {.importc: "rxkb_iso3166_code_ref".}
proc unref*(iso3166: ptr RxkbIso3166Code): ptr RxkbIso3166Code {.importc: "rxkb_iso3166_code_unref".}
proc get_code*(iso3166: ptr RxkbIso3166Code): cstring {.importc: "rxkb_iso3166_code_get_code".}
proc get_iso3166_first*(layout: ptr RXkbLayout): ptr RxkbIso3166Code {.importc: "rxkb_layout_get_iso3166_first".}
proc next*(iso3166: ptr RxkbIso3166Code): ptr RxkbIso3166Code {.importc: "rxkb_iso3166_code_next".}

{.pop.}
