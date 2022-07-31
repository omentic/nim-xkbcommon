# I've removed all comments again for ease of modification.

{.push dynlib: "libxkbcommon.so".}

discard "forward decl of rxkb_context"
discard "forward decl of rxkb_model"
discard "forward decl of rxkb_layout"
discard "forward decl of rxkb_option_group"
discard "forward decl of rxkb_option"
discard "forward decl of rxkb_iso639_code"
discard "forward decl of rxkb_iso3166_code"

type rxkb_popularity* = enum
  RXKB_POPULARITY_STANDARD = 1, RXKB_POPULARITY_EXOTIC

type rxkb_context_flags* = enum
  RXKB_CONTEXT_NO_FLAGS = 0,
  RXKB_CONTEXT_NO_DEFAULT_INCLUDES = (1 shl 0),
  RXKB_CONTEXT_LOAD_EXOTIC_RULES = (1 shl 1)

proc rxkb_context_new*(flags: rxkb_context_flags): ptr rxkb_context {.importc: "rxkb_context_new".}

type rxkb_log_level* = enum
  RXKB_LOG_LEVEL_CRITICAL = 10,
  RXKB_LOG_LEVEL_ERROR = 20,
  RXKB_LOG_LEVEL_WARNING = 30,
  RXKB_LOG_LEVEL_INFO = 40,
  RXKB_LOG_LEVEL_DEBUG = 50

proc rxkb_context_set_log_level*(ctx: ptr rxkb_context; level: rxkb_log_level) {.importc: "rxkb_context_set_log_level".}
proc rxkb_context_get_log_level*(ctx: ptr rxkb_context): rxkb_log_level {.importc: "rxkb_context_get_log_level".}
proc rxkb_context_set_log_fn*(ctx: ptr rxkb_context; log_fn: proc(ctx: ptr rxkb_context; level: rxkb_log_level; format: cstring; args: va_list)) {.importc: "rxkb_context_set_log_fn".}
proc rxkb_context_parse*(ctx: ptr rxkb_context; ruleset: cstring): bool {.importc: "rxkb_context_parse".}
proc rxkb_context_parse_default_ruleset*(ctx: ptr rxkb_context): bool {.importc: "rxkb_context_parse_default_ruleset".}
proc rxkb_context_ref*(ctx: ptr rxkb_context): ptr rxkb_context {.importc: "rxkb_context_ref".}
proc rxkb_context_unref*(ctx: ptr rxkb_context): ptr rxkb_context {.importc: "rxkb_context_unref".}

proc rxkb_context_set_user_data*(ctx: ptr rxkb_context; user_data: pointer) {.importc: "rxkb_context_set_user_data".}
proc rxkb_context_get_user_data*(ctx: ptr rxkb_context): pointer {.importc: "rxkb_context_get_user_data".}
proc rxkb_context_include_path_append*(ctx: ptr rxkb_context; path: cstring): bool {.importc: "rxkb_context_include_path_append".}
proc rxkb_context_include_path_append_default*(ctx: ptr rxkb_context): bool {.importc: "rxkb_context_include_path_append_default".}

proc rxkb_model_first*(ctx: ptr rxkb_context): ptr rxkb_model {.importc: "rxkb_model_first".}
proc rxkb_model_next*(m: ptr rxkb_model): ptr rxkb_model {.importc: "rxkb_model_next".}
proc rxkb_model_ref*(m: ptr rxkb_model): ptr rxkb_model {.importc: "rxkb_model_ref".}
proc rxkb_model_unref*(m: ptr rxkb_model): ptr rxkb_model {.importc: "rxkb_model_unref".}

proc rxkb_model_get_name*(m: ptr rxkb_model): cstring {.importc: "rxkb_model_get_name".}
proc rxkb_model_get_description*(m: ptr rxkb_model): cstring {.importc: "rxkb_model_get_description".}
proc rxkb_model_get_vendor*(m: ptr rxkb_model): cstring {.importc: "rxkb_model_get_vendor".}
proc rxkb_model_get_popularity*(m: ptr rxkb_model): rxkb_popularity {.importc: "rxkb_model_get_popularity".}

proc rxkb_layout_first*(ctx: ptr rxkb_context): ptr rxkb_layout {.importc: "rxkb_layout_first".}
proc rxkb_layout_next*(l: ptr rxkb_layout): ptr rxkb_layout {.importc: "rxkb_layout_next".}
proc rxkb_layout_ref*(l: ptr rxkb_layout): ptr rxkb_layout {.importc: "rxkb_layout_ref".}
proc rxkb_layout_unref*(l: ptr rxkb_layout): ptr rxkb_layout {.importc: "rxkb_layout_unref".}

proc rxkb_layout_get_name*(l: ptr rxkb_layout): cstring {.importc: "rxkb_layout_get_name".}
proc rxkb_layout_get_variant*(l: ptr rxkb_layout): cstring {.importc: "rxkb_layout_get_variant".}
proc rxkb_layout_get_brief*(l: ptr rxkb_layout): cstring {.importc: "rxkb_layout_get_brief".}
proc rxkb_layout_get_description*(l: ptr rxkb_layout): cstring {.importc: "rxkb_layout_get_description".}
proc rxkb_layout_get_popularity*(l: ptr rxkb_layout): rxkb_popularity {.importc: "rxkb_layout_get_popularity".}

proc rxkb_option_group_first*(ctx: ptr rxkb_context): ptr rxkb_option_group {.importc: "rxkb_option_group_first".}
proc rxkb_option_group_next*(g: ptr rxkb_option_group): ptr rxkb_option_group {.importc: "rxkb_option_group_next".}
proc rxkb_option_group_ref*(g: ptr rxkb_option_group): ptr rxkb_option_group {.importc: "rxkb_option_group_ref".}
proc rxkb_option_group_unref*(g: ptr rxkb_option_group): ptr rxkb_option_group {.importc: "rxkb_option_group_unref".}

proc rxkb_option_group_get_name*(m: ptr rxkb_option_group): cstring {.importc: "rxkb_option_group_get_name".}
proc rxkb_option_group_get_description*(m: ptr rxkb_option_group): cstring {.importc: "rxkb_option_group_get_description".}
proc rxkb_option_group_allows_multiple*(g: ptr rxkb_option_group): bool {.importc: "rxkb_option_group_allows_multiple".}
proc rxkb_option_group_get_popularity*(g: ptr rxkb_option_group): rxkb_popularity {.importc: "rxkb_option_group_get_popularity".}

proc rxkb_option_first*(group: ptr rxkb_option_group): ptr rxkb_option {.importc: "rxkb_option_first".}
proc rxkb_option_next*(o: ptr rxkb_option): ptr rxkb_option {.importc: "rxkb_option_next".}
proc rxkb_option_ref*(o: ptr rxkb_option): ptr rxkb_option {.importc: "rxkb_option_ref".}
proc rxkb_option_unref*(o: ptr rxkb_option): ptr rxkb_option {.importc: "rxkb_option_unref".}
proc rxkb_option_get_name*(o: ptr rxkb_option): cstring {.importc: "rxkb_option_get_name".}
proc rxkb_option_get_brief*(o: ptr rxkb_option): cstring {.importc: "rxkb_option_get_brief".}
proc rxkb_option_get_description*(o: ptr rxkb_option): cstring {.importc: "rxkb_option_get_description".}
proc rxkb_option_get_popularity*(o: ptr rxkb_option): rxkb_popularity {.importc: "rxkb_option_get_popularity".}

proc rxkb_iso639_code_ref*(iso639: ptr rxkb_iso639_code): ptr rxkb_iso639_code {.importc: "rxkb_iso639_code_ref".}
proc rxkb_iso639_code_unref*(iso639: ptr rxkb_iso639_code): ptr rxkb_iso639_code {.importc: "rxkb_iso639_code_unref".}
proc rxkb_iso639_code_get_code*(iso639: ptr rxkb_iso639_code): cstring {.importc: "rxkb_iso639_code_get_code".}
proc rxkb_layout_get_iso639_first*(layout: ptr rxkb_layout): ptr rxkb_iso639_code {.importc: "rxkb_layout_get_iso639_first".}
proc rxkb_iso639_code_next*(iso639: ptr rxkb_iso639_code): ptr rxkb_iso639_code {.importc: "rxkb_iso639_code_next".}

proc rxkb_iso3166_code_ref*(iso3166: ptr rxkb_iso3166_code): ptr rxkb_iso3166_code {.importc: "rxkb_iso3166_code_ref".}
proc rxkb_iso3166_code_unref*(iso3166: ptr rxkb_iso3166_code): ptr rxkb_iso3166_code {.importc: "rxkb_iso3166_code_unref".}
proc rxkb_iso3166_code_get_code*(iso3166: ptr rxkb_iso3166_code): cstring {.importc: "rxkb_iso3166_code_get_code".}
proc rxkb_layout_get_iso3166_first*(layout: ptr rxkb_layout): ptr rxkb_iso3166_code {.importc: "rxkb_layout_get_iso3166_first".}
proc rxkb_iso3166_code_next*(iso3166: ptr rxkb_iso3166_code): ptr rxkb_iso3166_code {.importc: "rxkb_iso3166_code_next".}

{.pop.}
