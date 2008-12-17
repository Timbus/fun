
.namespace []
.sub "_block11"  :anon :subid("10")
    get_hll_global $P14, ["fun";"Grammar";"Actions"], "_block13" 
    capture_lex $P14
    .return ($P14)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block13" :init :load :subid("31")
        $P0 = get_hll_global 'P6metaclass'
        $P1 = split '::', 'fun::Grammar::Actions'
        push_eh subclass_done
        $P2 = $P0.'new_class'($P1)
      subclass_done:
        pop_eh
    .const 'Sub' $P265 = "30" 
    capture_lex $P265
    .return ($P265)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "TOP"  :subid("11") :method
    .param pmc param_18
    new $P17, 'ExceptionHandler'
    set_addr $P17, control_16
    $P17."handle_types"(58)
    push_eh $P17
    .lex "$/", param_18
    get_hll_global $P19, ["PAST"], "Block"
    find_lex $P20, "$/"
    unless_null $P20, vivify_32
    new $P20, "Undef"
  vivify_32:
    get_hll_global $P21, ["PAST"], "Var"
    $P22 = $P21."new"("funstack" :named("name"), "Stack" :named("viviself"), "package" :named("scope"), 1 :named("isdecl"), 1 :named("lvalue"))
    $P23 = $P19."new"($P22, "declaration" :named("blocktype"), $P20 :named("node"))
    .lex "$past", $P23
    find_lex $P25, "$/"
    set $P26, $P25["func"]
    unless_null $P26, vivify_33
    new $P26, "Undef"
  vivify_33:
    defined $I28, $P26
    unless $I28, for_24_undef_iter
    new $P29, 'ExceptionHandler'
    set_addr $P29, for_24_next
    $P29."handle_types"(64)
    push_eh $P29
    iter $P27, $P26
  for_24:
    unless $P27, for_24_end
    shift $P30, $P27
    .const 'Sub' $P32 = "12" 
    capture_lex $P32
    $P82 = $P32($P30)
    goto for_24
  for_24_next:
    .local pmc exception 
    .get_results (exception) 
    set $P29, 0
    goto for_24
  for_24_end:
    pop_eh 
  for_24_undef_iter:
    new $P83, "Integer"
    assign $P83, 0
    .lex "$stacklist", $P83
    find_lex $P85, "$/"
    set $P86, $P85["expr"]
    unless_null $P86, vivify_50
    new $P86, "Undef"
  vivify_50:
    defined $I88, $P86
    unless $I88, for_84_undef_iter
    new $P89, 'ExceptionHandler'
    set_addr $P89, for_84_next
    $P89."handle_types"(64)
    push_eh $P89
    iter $P87, $P86
  for_84:
    unless $P87, for_84_end
    shift $P90, $P87
    .const 'Sub' $P92 = "14" 
    capture_lex $P92
    $P129 = $P92($P90)
    goto for_84
  for_84_next:
    .local pmc exception 
    .get_results (exception) 
    set $P89, 0
    goto for_84
  for_84_end:
    pop_eh 
  for_84_undef_iter:
    find_lex $P131, "$stacklist"
    unless_null $P131, vivify_62
    new $P131, "Undef"
  vivify_62:
    unless $P131, if_130_end
    .const 'Sub' $P133 = "19" 
    capture_lex $P133
    $P133()
  if_130_end:
    find_lex $P137, "$/"
    find_lex $P138, "$past"
    unless_null $P138, vivify_65
    new $P138, "Undef"
  vivify_65:
    $P139 = $P137."result_object"($P138)
    .return ($P139)
  control_16:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P140, exception, "payload"
    .return ($P140)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block31"  :anon :subid("12") :outer("11")
    .param pmc param_33
    .lex "$_", param_33
    find_lex $P34, "$_"
    unless_null $P34, vivify_34
    new $P34, "Hash"
  vivify_34:
    set $P35, $P34["funcname"]
    unless_null $P35, vivify_35
    new $P35, "Undef"
  vivify_35:
    .lex "$name", $P35
    get_hll_global $P36, ["PAST"], "Op"
    find_lex $P37, "$/"
    unless_null $P37, vivify_36
    new $P37, "Undef"
  vivify_36:
    $P38 = $P36."new"("!@mklist" :named("name"), "call" :named("pasttype"), $P37 :named("node"))
    .lex "$fnlist", $P38
    find_lex $P40, "$_"
    unless_null $P40, vivify_37
    new $P40, "Hash"
  vivify_37:
    set $P41, $P40["expr"]
    unless_null $P41, vivify_38
    new $P41, "Undef"
  vivify_38:
    defined $I43, $P41
    unless $I43, for_39_undef_iter
    new $P44, 'ExceptionHandler'
    set_addr $P44, for_39_next
    $P44."handle_types"(64)
    push_eh $P44
    iter $P42, $P41
  for_39:
    unless $P42, for_39_end
    shift $P45, $P42
    .const 'Sub' $P47 = "13" 
    capture_lex $P47
    $P53 = $P47($P45)
    goto for_39
  for_39_next:
    .local pmc exception 
    .get_results (exception) 
    set $P44, 0
    goto for_39
  for_39_end:
    pop_eh 
  for_39_undef_iter:
    find_lex $P54, "$past"
    unless_null $P54, vivify_41
    new $P54, "Undef"
  vivify_41:
    get_hll_global $P55, ["PAST"], "Op"
    find_lex $P56, "$/"
    unless_null $P56, vivify_42
    new $P56, "Undef"
  vivify_42:
    get_hll_global $P57, ["PAST"], "Var"
    new $P58, "String"
    assign $P58, "!usrfnlist"
    find_lex $P59, "$name"
    unless_null $P59, vivify_43
    new $P59, "Undef"
  vivify_43:
    concat $P60, $P58, $P59
    $P61 = $P57."new"($P60 :named("name"), "ResizablePMCArray" :named("viviself"), "package" :named("scope"), 1 :named("isdecl"), 1 :named("lvalue"))
    find_lex $P62, "$fnlist"
    unless_null $P62, vivify_44
    new $P62, "Undef"
  vivify_44:
    $P63 = $P55."new"($P61, $P62, "bind" :named("pasttype"), $P56 :named("node"))
    $P54."push"($P63)
    find_lex $P64, "$past"
    unless_null $P64, vivify_45
    new $P64, "Undef"
  vivify_45:
    get_hll_global $P65, ["PAST"], "Block"
    find_lex $P66, "$name"
    unless_null $P66, vivify_46
    new $P66, "Undef"
  vivify_46:
    find_lex $P67, "$/"
    unless_null $P67, vivify_47
    new $P67, "Undef"
  vivify_47:
    get_hll_global $P68, ["PAST"], "Op"
    find_lex $P69, "$/"
    unless_null $P69, vivify_48
    new $P69, "Undef"
  vivify_48:
    get_hll_global $P70, ["PAST"], "Var"
    $P71 = $P70."new"("funstack" :named("name"), "package" :named("scope"))
    get_hll_global $P72, ["PAST"], "Op"
    get_hll_global $P73, ["PAST"], "Var"
    new $P74, "String"
    assign $P74, "!usrfnlist"
    find_lex $P75, "$name"
    unless_null $P75, vivify_49
    new $P75, "Undef"
  vivify_49:
    concat $P76, $P74, $P75
    $P77 = $P73."new"($P76 :named("name"), "package" :named("scope"))
    $P78 = $P72."new"($P77, 1 :named("flat"), "!@deepcopy" :named("name"))
    $P79 = $P68."new"($P71, $P78, "push" :named("name"), "callmethod" :named("pasttype"), $P69 :named("node"))
    $P80 = $P65."new"($P79, $P66 :named("name"), "declaration" :named("blocktype"), $P67 :named("node"))
    $P81 = $P64."push"($P80)
    .return ($P81)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block46"  :anon :subid("13") :outer("12")
    .param pmc param_48
    .lex "$_", param_48
    find_lex $P49, "$fnlist"
    unless_null $P49, vivify_39
    new $P49, "Undef"
  vivify_39:
    find_lex $P50, "$_"
    unless_null $P50, vivify_40
    new $P50, "Undef"
  vivify_40:
    $P51 = $P50."item"()
    $P52 = $P49."push"($P51)
    .return ($P52)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block91"  :anon :subid("14") :outer("11")
    .param pmc param_93
    .lex "$_", param_93
    find_lex $P96, "$_"
    unless_null $P96, vivify_51
    new $P96, "Hash"
  vivify_51:
    set $P97, $P96["print"]
    unless_null $P97, vivify_52
    new $P97, "Undef"
  vivify_52:
    if $P97, if_95
    .const 'Sub' $P113 = "17" 
    capture_lex $P113
    $P128 = $P113()
    set $P94, $P128
    goto if_95_end
  if_95:
    .const 'Sub' $P99 = "15" 
    capture_lex $P99
    $P111 = $P99()
    set $P94, $P111
  if_95_end:
    .return ($P94)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block112"  :anon :subid("17") :outer("14")
    find_lex $P115, "$stacklist"
    unless_null $P115, vivify_53
    new $P115, "Undef"
  vivify_53:
    isfalse $I116, $P115
    unless $I116, if_114_end
    .const 'Sub' $P118 = "18" 
    capture_lex $P118
    $P118()
  if_114_end:
    find_lex $P124, "$stacklist"
    unless_null $P124, vivify_55
    new $P124, "Undef"
  vivify_55:
    find_lex $P125, "$_"
    unless_null $P125, vivify_56
    new $P125, "Undef"
  vivify_56:
    $P126 = $P125."item"()
    $P127 = $P124."push"($P126)
    .return ($P127)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block117"  :anon :subid("18") :outer("17")
    get_hll_global $P119, ["PAST"], "Op"
    find_lex $P120, "$/"
    unless_null $P120, vivify_54
    new $P120, "Undef"
  vivify_54:
    get_hll_global $P121, ["PAST"], "Var"
    $P122 = $P121."new"("funstack" :named("name"), "package" :named("scope"))
    $P123 = $P119."new"($P122, "push" :named("name"), "callmethod" :named("pasttype"), $P120 :named("node"))
    store_lex "$stacklist", $P123
    .return ($P123)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block98"  :anon :subid("15") :outer("14")
    find_lex $P101, "$stacklist"
    unless_null $P101, vivify_57
    new $P101, "Undef"
  vivify_57:
    unless $P101, if_100_end
    .const 'Sub' $P103 = "16" 
    capture_lex $P103
    $P103()
  if_100_end:
    find_lex $P107, "$past"
    unless_null $P107, vivify_60
    new $P107, "Undef"
  vivify_60:
    find_lex $P108, "$_"
    unless_null $P108, vivify_61
    new $P108, "Undef"
  vivify_61:
    $P109 = $P108."item"()
    $P107."push"($P109)
    new $P110, "Integer"
    assign $P110, 0
    store_lex "$stacklist", $P110
    .return ($P110)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block102"  :anon :subid("16") :outer("15")
    find_lex $P104, "$past"
    unless_null $P104, vivify_58
    new $P104, "Undef"
  vivify_58:
    find_lex $P105, "$stacklist"
    unless_null $P105, vivify_59
    new $P105, "Undef"
  vivify_59:
    $P106 = $P104."push"($P105)
    .return ($P106)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block132"  :anon :subid("19") :outer("11")
    find_lex $P134, "$past"
    unless_null $P134, vivify_63
    new $P134, "Undef"
  vivify_63:
    find_lex $P135, "$stacklist"
    unless_null $P135, vivify_64
    new $P135, "Undef"
  vivify_64:
    $P136 = $P134."push"($P135)
    .return ($P136)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "print"  :subid("20") :method
    .param pmc param_144
    new $P143, 'ExceptionHandler'
    set_addr $P143, control_142
    $P143."handle_types"(58)
    push_eh $P143
    .lex "$/", param_144
    find_lex $P145, "$/"
    get_hll_global $P146, ["PAST"], "Op"
    $P147 = $P146."new"("call" :named("pasttype"), "." :named("name"))
    $P148 = $P145."result_object"($P147)
    .return ($P148)
  control_142:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P149, exception, "payload"
    .return ($P149)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "expr"  :subid("21") :method
    .param pmc param_153
    .param pmc param_154
    new $P152, 'ExceptionHandler'
    set_addr $P152, control_151
    $P152."handle_types"(58)
    push_eh $P152
    .lex "$/", param_153
    .lex "$key", param_154
    find_lex $P155, "$/"
    find_lex $P156, "$key"
    unless_null $P156, vivify_66
    new $P156, "Undef"
  vivify_66:
    find_lex $P157, "$/"
    unless_null $P157, vivify_67
    new $P157, "Hash"
  vivify_67:
    set $P158, $P157[$P156]
    unless_null $P158, vivify_68
    new $P158, "Undef"
  vivify_68:
    $P159 = $P158."item"()
    $P160 = $P155."result_object"($P159)
    .return ($P160)
  control_151:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P161, exception, "payload"
    .return ($P161)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "list"  :subid("22") :method
    .param pmc param_165
    new $P164, 'ExceptionHandler'
    set_addr $P164, control_163
    $P164."handle_types"(58)
    push_eh $P164
    .lex "$/", param_165
    get_hll_global $P166, ["PAST"], "Op"
    find_lex $P167, "$/"
    unless_null $P167, vivify_69
    new $P167, "Undef"
  vivify_69:
    $P168 = $P166."new"("!@mklist" :named("name"), "call" :named("pasttype"), $P167 :named("node"))
    .lex "$past", $P168
    find_lex $P170, "$/"
    set $P171, $P170["expr"]
    unless_null $P171, vivify_70
    new $P171, "Undef"
  vivify_70:
    defined $I173, $P171
    unless $I173, for_169_undef_iter
    new $P174, 'ExceptionHandler'
    set_addr $P174, for_169_next
    $P174."handle_types"(64)
    push_eh $P174
    iter $P172, $P171
  for_169:
    unless $P172, for_169_end
    shift $P175, $P172
    .const 'Sub' $P177 = "23" 
    capture_lex $P177
    $P183 = $P177($P175)
    goto for_169
  for_169_next:
    .local pmc exception 
    .get_results (exception) 
    set $P174, 0
    goto for_169
  for_169_end:
    pop_eh 
  for_169_undef_iter:
    find_lex $P184, "$/"
    find_lex $P185, "$past"
    unless_null $P185, vivify_73
    new $P185, "Undef"
  vivify_73:
    $P186 = $P184."result_object"($P185)
    .return ($P186)
  control_163:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P187, exception, "payload"
    .return ($P187)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block176"  :anon :subid("23") :outer("22")
    .param pmc param_178
    .lex "$_", param_178
    find_lex $P179, "$past"
    unless_null $P179, vivify_71
    new $P179, "Undef"
  vivify_71:
    find_lex $P180, "$_"
    unless_null $P180, vivify_72
    new $P180, "Undef"
  vivify_72:
    $P181 = $P180."item"()
    $P182 = $P179."push"($P181)
    .return ($P182)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "value"  :subid("24") :method
    .param pmc param_191
    .param pmc param_192
    new $P190, 'ExceptionHandler'
    set_addr $P190, control_189
    $P190."handle_types"(58)
    push_eh $P190
    .lex "$/", param_191
    .lex "$key", param_192
    find_lex $P193, "$/"
    find_lex $P194, "$key"
    unless_null $P194, vivify_74
    new $P194, "Undef"
  vivify_74:
    find_lex $P195, "$/"
    unless_null $P195, vivify_75
    new $P195, "Hash"
  vivify_75:
    set $P196, $P195[$P194]
    unless_null $P196, vivify_76
    new $P196, "Undef"
  vivify_76:
    $P197 = $P196."item"()
    $P198 = $P193."result_object"($P197)
    .return ($P198)
  control_189:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P199, exception, "payload"
    .return ($P199)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "integer"  :subid("25") :method
    .param pmc param_203
    new $P202, 'ExceptionHandler'
    set_addr $P202, control_201
    $P202."handle_types"(58)
    push_eh $P202
    .lex "$/", param_203
    find_lex $P204, "$/"
    get_hll_global $P205, ["PAST"], "Val"
    find_lex $P206, "$/"
    unless_null $P206, vivify_77
    new $P206, "Undef"
  vivify_77:
    set $S207, $P206
    find_lex $P208, "$/"
    unless_null $P208, vivify_78
    new $P208, "Undef"
  vivify_78:
    $P209 = $P205."new"($S207 :named("value"), "Integer" :named("returns"), $P208 :named("node"))
    $P210 = $P204."result_object"($P209)
    .return ($P210)
  control_201:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P211, exception, "payload"
    .return ($P211)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "float"  :subid("26") :method
    .param pmc param_215
    new $P214, 'ExceptionHandler'
    set_addr $P214, control_213
    $P214."handle_types"(58)
    push_eh $P214
    .lex "$/", param_215
    find_lex $P216, "$/"
    get_hll_global $P217, ["PAST"], "Val"
    find_lex $P218, "$/"
    unless_null $P218, vivify_79
    new $P218, "Undef"
  vivify_79:
    set $S219, $P218
    find_lex $P220, "$/"
    unless_null $P220, vivify_80
    new $P220, "Undef"
  vivify_80:
    $P221 = $P217."new"($S219 :named("value"), "Float" :named("returns"), $P220 :named("node"))
    $P222 = $P216."result_object"($P221)
    .return ($P222)
  control_213:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P223, exception, "payload"
    .return ($P223)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "bool"  :subid("27") :method
    .param pmc param_227
    new $P226, 'ExceptionHandler'
    set_addr $P226, control_225
    $P226."handle_types"(58)
    push_eh $P226
    .lex "$/", param_227
    find_lex $P228, "$/"
    get_hll_global $P229, ["PAST"], "Val"
    find_lex $P232, "$/"
    unless_null $P232, vivify_81
    new $P232, "Undef"
  vivify_81:
    set $S233, $P232
    iseq $I234, $S233, "true"
    if $I234, if_231
    new $P236, "Integer"
    assign $P236, 0
    set $P230, $P236
    goto if_231_end
  if_231:
    new $P235, "Integer"
    assign $P235, 1
    set $P230, $P235
  if_231_end:
    find_lex $P237, "$/"
    unless_null $P237, vivify_82
    new $P237, "Undef"
  vivify_82:
    $P238 = $P229."new"($P230 :named("value"), "Boolean" :named("returns"), $P237 :named("node"))
    $P239 = $P228."result_object"($P238)
    .return ($P239)
  control_225:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P240, exception, "payload"
    .return ($P240)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "string"  :subid("28") :method
    .param pmc param_244
    new $P243, 'ExceptionHandler'
    set_addr $P243, control_242
    $P243."handle_types"(58)
    push_eh $P243
    .lex "$/", param_244
    find_lex $P245, "$/"
    get_hll_global $P246, ["PAST"], "Val"
    find_lex $P247, "$/"
    set $P248, $P247["string_literal"]
    unless_null $P248, vivify_83
    new $P248, "Undef"
  vivify_83:
    $P249 = $P248."item"()
    find_lex $P250, "$/"
    unless_null $P250, vivify_84
    new $P250, "Undef"
  vivify_84:
    $P251 = $P246."new"($P249 :named("value"), "String" :named("returns"), $P250 :named("node"))
    $P252 = $P245."result_object"($P251)
    .return ($P252)
  control_242:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P253, exception, "payload"
    .return ($P253)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "builtins"  :subid("29") :method
    .param pmc param_257
    new $P256, 'ExceptionHandler'
    set_addr $P256, control_255
    $P256."handle_types"(58)
    push_eh $P256
    .lex "$/", param_257
    find_lex $P258, "$/"
    get_hll_global $P259, ["PAST"], "Var"
    find_lex $P260, "$/"
    unless_null $P260, vivify_85
    new $P260, "Undef"
  vivify_85:
    set $S261, $P260
    $P262 = $P259."new"($S261 :named("name"), "package" :named("scope"))
    $P263 = $P258."result_object"($P262)
    .return ($P263)
  control_255:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P264, exception, "payload"
    .return ($P264)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "userfunccall"  :subid("30") :method
    .param pmc param_268
    new $P267, 'ExceptionHandler'
    set_addr $P267, control_266
    $P267."handle_types"(58)
    push_eh $P267
    .lex "$/", param_268
    find_lex $P269, "$/"
    get_hll_global $P270, ["PAST"], "Op"
    find_lex $P271, "$/"
    unless_null $P271, vivify_86
    new $P271, "Undef"
  vivify_86:
    get_hll_global $P272, ["PAST"], "Op"
    find_lex $P273, "$/"
    unless_null $P273, vivify_87
    new $P273, "Undef"
  vivify_87:
    get_hll_global $P274, ["PAST"], "Var"
    find_lex $P275, "$/"
    set $P276, $P275["funcname"]
    unless_null $P276, vivify_88
    new $P276, "Undef"
  vivify_88:
    find_lex $P277, "$/"
    unless_null $P277, vivify_89
    new $P277, "Undef"
  vivify_89:
    $P278 = $P274."new"($P276 :named("name"), "package" :named("scope"), $P277 :named("node"))
    $P279 = $P272."new"($P278, "isnull" :named("pirop"), $P273 :named("node"))
    get_hll_global $P280, ["PAST"], "Op"
    get_hll_global $P281, ["PAST"], "Val"
    new $P282, "String"
    assign $P282, "\"Error: The function '"
    find_lex $P283, "$/"
    set $P284, $P283["funcname"]
    unless_null $P284, vivify_90
    new $P284, "Undef"
  vivify_90:
    concat $P285, $P282, $P284
    concat $P286, $P285, "' is not defined. Perhaps you misspelled it?\""
    find_lex $P287, "$/"
    unless_null $P287, vivify_91
    new $P287, "Undef"
  vivify_91:
    $P288 = $P281."new"($P286 :named("value"), "Exception" :named("returns"), $P287 :named("node"))
    $P289 = $P280."new"($P288, "throw" :named("pirop"))
    $P290 = $P270."new"($P279, $P289, "if" :named("pasttype"), $P271 :named("node"))
    $P291 = $P269."result_object"($P290)
    .return ($P291)
  control_266:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P292, exception, "payload"
    .return ($P292)
    rethrow exception
.end

