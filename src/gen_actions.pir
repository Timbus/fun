
.namespace []
.sub "_block11"  :anon :subid("12")
    get_hll_global $P14, ["fun";"Grammar";"Actions"], "_block13" 
    capture_lex $P14
    .return ($P14)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block13" :init :load :subid("13")
        $P0 = get_hll_global 'P6metaclass'
        $P1 = split '::', 'fun::Grammar::Actions'
        push_eh subclass_done
        $P2 = $P0.'new_class'($P1)
      subclass_done:
        pop_eh
    .const 'Sub' $P267 = "userfunccall" 
    capture_lex $P267
    .return ($P267)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "TOP"  :subid("14") :method
    .param pmc param_18
    new $P17, 'ExceptionHandler'
    set_addr $P17, control_16
    $P17."handle_types"(58)
    push_eh $P17
    .lex "$/", param_18
    get_hll_global $P19, ["PAST"], "Block"
    find_lex $P20, "$/"
    unless_null $P20, vivify_10
    new $P20, "Undef"
  vivify_10:
    get_hll_global $P21, ["PAST"], "Var"
    $P22 = $P21."new"("funstack" :named("name"), "Stack" :named("viviself"), "package" :named("scope"), 1 :named("isdecl"), 1 :named("lvalue"))
    $P23 = $P19."new"($P22, "declaration" :named("blocktype"), $P20 :named("node"))
    .lex "$past", $P23
    find_lex $P25, "$/"
    set $P26, $P25["func"]
    unless_null $P26, vivify_11
    new $P26, "Undef"
  vivify_11:
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
    .const 'Sub' $P32 = "_block31" 
    capture_lex $P32
    $P84 = $P32($P30)
    goto for_24
  for_24_next:
    .local pmc exception 
    .get_results (exception) 
    set $P29, 0
    goto for_24
  for_24_end:
    pop_eh 
  for_24_undef_iter:
    new $P85, "Integer"
    assign $P85, 0
    .lex "$stacklist", $P85
    find_lex $P87, "$/"
    set $P88, $P87["expr"]
    unless_null $P88, vivify_28
    new $P88, "Undef"
  vivify_28:
    defined $I90, $P88
    unless $I90, for_86_undef_iter
    new $P91, 'ExceptionHandler'
    set_addr $P91, for_86_next
    $P91."handle_types"(64)
    push_eh $P91
    iter $P89, $P88
  for_86:
    unless $P89, for_86_end
    shift $P92, $P89
    .const 'Sub' $P94 = "_block93" 
    capture_lex $P94
    $P131 = $P94($P92)
    goto for_86
  for_86_next:
    .local pmc exception 
    .get_results (exception) 
    set $P91, 0
    goto for_86
  for_86_end:
    pop_eh 
  for_86_undef_iter:
    find_lex $P133, "$stacklist"
    unless_null $P133, vivify_40
    new $P133, "Undef"
  vivify_40:
    unless $P133, if_132_end
    .const 'Sub' $P135 = "_block134" 
    capture_lex $P135
    $P135()
  if_132_end:
    find_lex $P139, "$/"
    find_lex $P140, "$past"
    unless_null $P140, vivify_43
    new $P140, "Undef"
  vivify_43:
    $P141 = $P139."result_object"($P140)
    .return ($P141)
  control_16:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P142, exception, "payload"
    .return ($P142)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block31"  :anon :subid("15") :outer("14")
    .param pmc param_33
    .lex "$_", param_33
    find_lex $P34, "$_"
    unless_null $P34, vivify_12
    new $P34, "Hash"
  vivify_12:
    set $P35, $P34["funcname"]
    unless_null $P35, vivify_13
    new $P35, "Undef"
  vivify_13:
    .lex "$name", $P35
    get_hll_global $P36, ["PAST"], "Op"
    find_lex $P37, "$/"
    unless_null $P37, vivify_14
    new $P37, "Undef"
  vivify_14:
    $P38 = $P36."new"("!@mklist" :named("name"), "call" :named("pasttype"), $P37 :named("node"))
    .lex "$fnlist", $P38
    find_lex $P40, "$_"
    unless_null $P40, vivify_15
    new $P40, "Hash"
  vivify_15:
    set $P41, $P40["expr"]
    unless_null $P41, vivify_16
    new $P41, "Undef"
  vivify_16:
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
    .const 'Sub' $P47 = "_block46" 
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
    unless_null $P54, vivify_19
    new $P54, "Undef"
  vivify_19:
    get_hll_global $P55, ["PAST"], "Op"
    find_lex $P56, "$/"
    unless_null $P56, vivify_20
    new $P56, "Undef"
  vivify_20:
    get_hll_global $P57, ["PAST"], "Var"
    new $P58, "String"
    assign $P58, "!usrfnlist"
    find_lex $P59, "$name"
    unless_null $P59, vivify_21
    new $P59, "Undef"
  vivify_21:
    concat $P60, $P58, $P59
    $P61 = $P57."new"($P60 :named("name"), "ResizablePMCArray" :named("viviself"), "package" :named("scope"), 1 :named("isdecl"), 1 :named("lvalue"))
    find_lex $P62, "$fnlist"
    unless_null $P62, vivify_22
    new $P62, "Undef"
  vivify_22:
    $P63 = $P55."new"($P61, $P62, "bind" :named("pasttype"), $P56 :named("node"))
    $P54."push"($P63)
    find_lex $P64, "$past"
    unless_null $P64, vivify_23
    new $P64, "Undef"
  vivify_23:
    get_hll_global $P65, ["PAST"], "Block"
    new $P66, "String"
    assign $P66, "!usrfn"
    find_lex $P67, "$name"
    unless_null $P67, vivify_24
    new $P67, "Undef"
  vivify_24:
    concat $P68, $P66, $P67
    find_lex $P69, "$/"
    unless_null $P69, vivify_25
    new $P69, "Undef"
  vivify_25:
    get_hll_global $P70, ["PAST"], "Op"
    find_lex $P71, "$/"
    unless_null $P71, vivify_26
    new $P71, "Undef"
  vivify_26:
    get_hll_global $P72, ["PAST"], "Var"
    $P73 = $P72."new"("funstack" :named("name"), "package" :named("scope"))
    get_hll_global $P74, ["PAST"], "Op"
    get_hll_global $P75, ["PAST"], "Var"
    new $P76, "String"
    assign $P76, "!usrfnlist"
    find_lex $P77, "$name"
    unless_null $P77, vivify_27
    new $P77, "Undef"
  vivify_27:
    concat $P78, $P76, $P77
    $P79 = $P75."new"($P78 :named("name"), "package" :named("scope"))
    $P80 = $P74."new"($P79, 1 :named("flat"), "deepcopy" :named("name"))
    $P81 = $P70."new"($P73, $P80, "push" :named("name"), "callmethod" :named("pasttype"), $P71 :named("node"))
    $P82 = $P65."new"($P81, $P68 :named("name"), "declaration" :named("blocktype"), $P69 :named("node"))
    $P83 = $P64."push"($P82)
    .return ($P83)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block46"  :anon :subid("16") :outer("15")
    .param pmc param_48
    .lex "$_", param_48
    find_lex $P49, "$fnlist"
    unless_null $P49, vivify_17
    new $P49, "Undef"
  vivify_17:
    find_lex $P50, "$_"
    unless_null $P50, vivify_18
    new $P50, "Undef"
  vivify_18:
    $P51 = $P50."item"()
    $P52 = $P49."push"($P51)
    .return ($P52)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block93"  :anon :subid("17") :outer("14")
    .param pmc param_95
    .lex "$_", param_95
    find_lex $P98, "$_"
    unless_null $P98, vivify_29
    new $P98, "Hash"
  vivify_29:
    set $P99, $P98["print"]
    unless_null $P99, vivify_30
    new $P99, "Undef"
  vivify_30:
    if $P99, if_97
    .const 'Sub' $P115 = "_block114" 
    capture_lex $P115
    $P130 = $P115()
    set $P96, $P130
    goto if_97_end
  if_97:
    .const 'Sub' $P101 = "_block100" 
    capture_lex $P101
    $P113 = $P101()
    set $P96, $P113
  if_97_end:
    .return ($P96)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block114"  :anon :subid("18") :outer("17")
    find_lex $P117, "$stacklist"
    unless_null $P117, vivify_31
    new $P117, "Undef"
  vivify_31:
    isfalse $I118, $P117
    unless $I118, if_116_end
    .const 'Sub' $P120 = "_block119" 
    capture_lex $P120
    $P120()
  if_116_end:
    find_lex $P126, "$stacklist"
    unless_null $P126, vivify_33
    new $P126, "Undef"
  vivify_33:
    find_lex $P127, "$_"
    unless_null $P127, vivify_34
    new $P127, "Undef"
  vivify_34:
    $P128 = $P127."item"()
    $P129 = $P126."push"($P128)
    .return ($P129)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block119"  :anon :subid("19") :outer("18")
    get_hll_global $P121, ["PAST"], "Op"
    find_lex $P122, "$/"
    unless_null $P122, vivify_32
    new $P122, "Undef"
  vivify_32:
    get_hll_global $P123, ["PAST"], "Var"
    $P124 = $P123."new"("funstack" :named("name"), "package" :named("scope"))
    $P125 = $P121."new"($P124, "push" :named("name"), "callmethod" :named("pasttype"), $P122 :named("node"))
    store_lex "$stacklist", $P125
    .return ($P125)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block100"  :anon :subid("20") :outer("17")
    find_lex $P103, "$stacklist"
    unless_null $P103, vivify_35
    new $P103, "Undef"
  vivify_35:
    unless $P103, if_102_end
    .const 'Sub' $P105 = "_block104" 
    capture_lex $P105
    $P105()
  if_102_end:
    find_lex $P109, "$past"
    unless_null $P109, vivify_38
    new $P109, "Undef"
  vivify_38:
    find_lex $P110, "$_"
    unless_null $P110, vivify_39
    new $P110, "Undef"
  vivify_39:
    $P111 = $P110."item"()
    $P109."push"($P111)
    new $P112, "Integer"
    assign $P112, 0
    store_lex "$stacklist", $P112
    .return ($P112)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block104"  :anon :subid("21") :outer("20")
    find_lex $P106, "$past"
    unless_null $P106, vivify_36
    new $P106, "Undef"
  vivify_36:
    find_lex $P107, "$stacklist"
    unless_null $P107, vivify_37
    new $P107, "Undef"
  vivify_37:
    $P108 = $P106."push"($P107)
    .return ($P108)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block134"  :anon :subid("22") :outer("14")
    find_lex $P136, "$past"
    unless_null $P136, vivify_41
    new $P136, "Undef"
  vivify_41:
    find_lex $P137, "$stacklist"
    unless_null $P137, vivify_42
    new $P137, "Undef"
  vivify_42:
    $P138 = $P136."push"($P137)
    .return ($P138)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "print"  :subid("23") :method
    .param pmc param_146
    new $P145, 'ExceptionHandler'
    set_addr $P145, control_144
    $P145."handle_types"(58)
    push_eh $P145
    .lex "$/", param_146
    find_lex $P147, "$/"
    get_hll_global $P148, ["PAST"], "Op"
    $P149 = $P148."new"("call" :named("pasttype"), "." :named("name"))
    $P150 = $P147."result_object"($P149)
    .return ($P150)
  control_144:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P151, exception, "payload"
    .return ($P151)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "expr"  :subid("24") :method
    .param pmc param_155
    .param pmc param_156
    new $P154, 'ExceptionHandler'
    set_addr $P154, control_153
    $P154."handle_types"(58)
    push_eh $P154
    .lex "$/", param_155
    .lex "$key", param_156
    find_lex $P157, "$/"
    find_lex $P158, "$key"
    unless_null $P158, vivify_44
    new $P158, "Undef"
  vivify_44:
    find_lex $P159, "$/"
    unless_null $P159, vivify_45
    new $P159, "Hash"
  vivify_45:
    set $P160, $P159[$P158]
    unless_null $P160, vivify_46
    new $P160, "Undef"
  vivify_46:
    $P161 = $P160."item"()
    $P162 = $P157."result_object"($P161)
    .return ($P162)
  control_153:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P163, exception, "payload"
    .return ($P163)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "list"  :subid("25") :method
    .param pmc param_167
    new $P166, 'ExceptionHandler'
    set_addr $P166, control_165
    $P166."handle_types"(58)
    push_eh $P166
    .lex "$/", param_167
    get_hll_global $P168, ["PAST"], "Op"
    find_lex $P169, "$/"
    unless_null $P169, vivify_47
    new $P169, "Undef"
  vivify_47:
    $P170 = $P168."new"("!@mklist" :named("name"), "call" :named("pasttype"), $P169 :named("node"))
    .lex "$past", $P170
    find_lex $P172, "$/"
    set $P173, $P172["expr"]
    unless_null $P173, vivify_48
    new $P173, "Undef"
  vivify_48:
    defined $I175, $P173
    unless $I175, for_171_undef_iter
    new $P176, 'ExceptionHandler'
    set_addr $P176, for_171_next
    $P176."handle_types"(64)
    push_eh $P176
    iter $P174, $P173
  for_171:
    unless $P174, for_171_end
    shift $P177, $P174
    .const 'Sub' $P179 = "_block178" 
    capture_lex $P179
    $P185 = $P179($P177)
    goto for_171
  for_171_next:
    .local pmc exception 
    .get_results (exception) 
    set $P176, 0
    goto for_171
  for_171_end:
    pop_eh 
  for_171_undef_iter:
    find_lex $P186, "$/"
    find_lex $P187, "$past"
    unless_null $P187, vivify_51
    new $P187, "Undef"
  vivify_51:
    $P188 = $P186."result_object"($P187)
    .return ($P188)
  control_165:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P189, exception, "payload"
    .return ($P189)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "_block178"  :anon :subid("26") :outer("25")
    .param pmc param_180
    .lex "$_", param_180
    find_lex $P181, "$past"
    unless_null $P181, vivify_49
    new $P181, "Undef"
  vivify_49:
    find_lex $P182, "$_"
    unless_null $P182, vivify_50
    new $P182, "Undef"
  vivify_50:
    $P183 = $P182."item"()
    $P184 = $P181."push"($P183)
    .return ($P184)
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "value"  :subid("27") :method
    .param pmc param_193
    .param pmc param_194
    new $P192, 'ExceptionHandler'
    set_addr $P192, control_191
    $P192."handle_types"(58)
    push_eh $P192
    .lex "$/", param_193
    .lex "$key", param_194
    find_lex $P195, "$/"
    find_lex $P196, "$key"
    unless_null $P196, vivify_52
    new $P196, "Undef"
  vivify_52:
    find_lex $P197, "$/"
    unless_null $P197, vivify_53
    new $P197, "Hash"
  vivify_53:
    set $P198, $P197[$P196]
    unless_null $P198, vivify_54
    new $P198, "Undef"
  vivify_54:
    $P199 = $P198."item"()
    $P200 = $P195."result_object"($P199)
    .return ($P200)
  control_191:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P201, exception, "payload"
    .return ($P201)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "integer"  :subid("28") :method
    .param pmc param_205
    new $P204, 'ExceptionHandler'
    set_addr $P204, control_203
    $P204."handle_types"(58)
    push_eh $P204
    .lex "$/", param_205
    find_lex $P206, "$/"
    get_hll_global $P207, ["PAST"], "Val"
    find_lex $P208, "$/"
    unless_null $P208, vivify_55
    new $P208, "Undef"
  vivify_55:
    set $S209, $P208
    find_lex $P210, "$/"
    unless_null $P210, vivify_56
    new $P210, "Undef"
  vivify_56:
    $P211 = $P207."new"($S209 :named("value"), "Integer" :named("returns"), $P210 :named("node"))
    $P212 = $P206."result_object"($P211)
    .return ($P212)
  control_203:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P213, exception, "payload"
    .return ($P213)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "float"  :subid("29") :method
    .param pmc param_217
    new $P216, 'ExceptionHandler'
    set_addr $P216, control_215
    $P216."handle_types"(58)
    push_eh $P216
    .lex "$/", param_217
    find_lex $P218, "$/"
    get_hll_global $P219, ["PAST"], "Val"
    find_lex $P220, "$/"
    unless_null $P220, vivify_57
    new $P220, "Undef"
  vivify_57:
    set $S221, $P220
    find_lex $P222, "$/"
    unless_null $P222, vivify_58
    new $P222, "Undef"
  vivify_58:
    $P223 = $P219."new"($S221 :named("value"), "Float" :named("returns"), $P222 :named("node"))
    $P224 = $P218."result_object"($P223)
    .return ($P224)
  control_215:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P225, exception, "payload"
    .return ($P225)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "bool"  :subid("30") :method
    .param pmc param_229
    new $P228, 'ExceptionHandler'
    set_addr $P228, control_227
    $P228."handle_types"(58)
    push_eh $P228
    .lex "$/", param_229
    find_lex $P230, "$/"
    get_hll_global $P231, ["PAST"], "Val"
    find_lex $P234, "$/"
    unless_null $P234, vivify_59
    new $P234, "Undef"
  vivify_59:
    set $S235, $P234
    iseq $I236, $S235, "true"
    if $I236, if_233
    new $P238, "Integer"
    assign $P238, 0
    set $P232, $P238
    goto if_233_end
  if_233:
    new $P237, "Integer"
    assign $P237, 1
    set $P232, $P237
  if_233_end:
    find_lex $P239, "$/"
    unless_null $P239, vivify_60
    new $P239, "Undef"
  vivify_60:
    $P240 = $P231."new"($P232 :named("value"), "Boolean" :named("returns"), $P239 :named("node"))
    $P241 = $P230."result_object"($P240)
    .return ($P241)
  control_227:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P242, exception, "payload"
    .return ($P242)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "string"  :subid("31") :method
    .param pmc param_246
    new $P245, 'ExceptionHandler'
    set_addr $P245, control_244
    $P245."handle_types"(58)
    push_eh $P245
    .lex "$/", param_246
    find_lex $P247, "$/"
    get_hll_global $P248, ["PAST"], "Val"
    find_lex $P249, "$/"
    set $P250, $P249["string_literal"]
    unless_null $P250, vivify_61
    new $P250, "Undef"
  vivify_61:
    $P251 = $P250."item"()
    find_lex $P252, "$/"
    unless_null $P252, vivify_62
    new $P252, "Undef"
  vivify_62:
    $P253 = $P248."new"($P251 :named("value"), "String" :named("returns"), $P252 :named("node"))
    $P254 = $P247."result_object"($P253)
    .return ($P254)
  control_244:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P255, exception, "payload"
    .return ($P255)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "builtins"  :subid("32") :method
    .param pmc param_259
    new $P258, 'ExceptionHandler'
    set_addr $P258, control_257
    $P258."handle_types"(58)
    push_eh $P258
    .lex "$/", param_259
    find_lex $P260, "$/"
    get_hll_global $P261, ["PAST"], "Var"
    find_lex $P262, "$/"
    unless_null $P262, vivify_63
    new $P262, "Undef"
  vivify_63:
    set $S263, $P262
    $P264 = $P261."new"($S263 :named("name"), "package" :named("scope"))
    $P265 = $P260."result_object"($P264)
    .return ($P265)
  control_257:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P266, exception, "payload"
    .return ($P266)
    rethrow exception
.end


.namespace ["fun";"Grammar";"Actions"]
.sub "userfunccall"  :subid("33") :method
    .param pmc param_270
    new $P269, 'ExceptionHandler'
    set_addr $P269, control_268
    $P269."handle_types"(58)
    push_eh $P269
    .lex "$/", param_270
    find_lex $P271, "$/"
    get_hll_global $P272, ["PAST"], "Var"
    new $P273, "String"
    assign $P273, "!usrfn"
    find_lex $P274, "$/"
    set $P275, $P274["funcname"]
    unless_null $P275, vivify_64
    new $P275, "Undef"
  vivify_64:
    concat $P276, $P273, $P275
    $P277 = $P272."new"($P276 :named("name"), "package" :named("scope"))
    $P278 = $P271."result_object"($P277)
    .return ($P278)
  control_268:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P279, exception, "payload"
    .return ($P279)
    rethrow exception
.end

