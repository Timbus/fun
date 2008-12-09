      .sub '__onload' :load :init
          .local pmc optable
          ## namespace fun::Grammar
          push_eh onload_1203
          .local pmc p6meta
          p6meta = get_hll_global 'P6metaclass'
          p6meta.'new_class'('fun::Grammar', 'parent'=>'PCT::Grammar')
        onload_1203:
          pop_eh
          .return ()
      .end

## <fun::Grammar::TOP>
.namespace ["fun";"Grammar"]
      .sub "TOP" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R: # concat
        R239: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R239_1
          $P0 = find_method mob, 'ws'
          goto R239_2
        R239_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R239_2
          say "Unable to find regex 'ws'"
        R239_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R240
          
          goto fail
        R240:  # quant 0..Inf none
          local_branch cstack, R240_repeat
          if cutmark != 243 goto fail
          cutmark = 0
          goto fail
        R240_repeat:
          push ustack, pos
          local_branch cstack, R242
          pos = pop ustack
          if cutmark != 0 goto fail
          local_branch cstack, R241
          if cutmark != 0 goto fail
          cutmark = 243
          goto fail
        R242:  # alt R244, R245
          push ustack, pos
          local_branch cstack, R244
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R245

        R244: # subrule func
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'func'
          if $I0 == 0 goto R244_1
          $P0 = find_method mob, 'func'
          goto R244_2
        R244_1:
          $P0 = find_name 'func'
          unless null $P0 goto R244_2
          say "Unable to find regex 'func'"
        R244_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
                    $I0 = defined captscope["func"]
          if $I0 goto R244_cgen
          $P0 = new 'ResizablePMCArray'
          captscope["func"] = $P0
          local_branch cstack, R244_cgen
          delete captscope["func"]
          goto fail
        R244_cgen:

          $P2 = captscope["func"]
          push $P2, captob

          pos = $P1
          local_branch cstack, R240_repeat
          $P2 = captscope["func"]
          $P2 = pop $P2

          goto fail
        R245: # subrule expr
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'expr'
          if $I0 == 0 goto R245_1
          $P0 = find_method mob, 'expr'
          goto R245_2
        R245_1:
          $P0 = find_name 'expr'
          unless null $P0 goto R245_2
          say "Unable to find regex 'expr'"
        R245_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
                    $I0 = defined captscope["expr"]
          if $I0 goto R245_cgen
          $P0 = new 'ResizablePMCArray'
          captscope["expr"] = $P0
          local_branch cstack, R245_cgen
          delete captscope["expr"]
          goto fail
        R245_cgen:

          $P2 = captscope["expr"]
          push $P2, captob

          pos = $P1
          local_branch cstack, R240_repeat
          $P2 = captscope["expr"]
          $P2 = pop $P2

          goto fail
        R241: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R241_1
          $P0 = find_method mob, 'ws'
          goto R241_2
        R241_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R241_2
          say "Unable to find regex 'ws'"
        R241_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R246
          
          goto fail
        R246:  # group 238
          local_branch cstack, R248
          if cutmark != 238 goto fail
          cutmark = 0
          goto fail

        R248: # concat
        R249:  # alt R251, R252
          push ustack, pos
          local_branch cstack, R251
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R252

        R251: # concat
        R253: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R253_1
          $P0 = find_method mob, 'ws'
          goto R253_2
        R253_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R253_2
          say "Unable to find regex 'ws'"
        R253_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R254
          
          goto fail
        R254: # anchor eos
          if pos == lastpos goto R255
          goto fail
        R255: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R255_1
          $P0 = find_method mob, 'ws'
          goto R255_2
        R255_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R255_2
          say "Unable to find regex 'ws'"
        R255_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R250
          
          goto fail
        R252: # concat
        R256: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R256_1
          $P0 = find_method mob, 'ws'
          goto R256_2
        R256_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R256_2
          say "Unable to find regex 'ws'"
        R256_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R257
          
          goto fail
        R257: # subrule panic
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'panic'
          if $I0 == 0 goto R257_1
          $P0 = find_method mob, 'panic'
          goto R257_2
        R257_1:
          $P0 = find_name 'panic'
          unless null $P0 goto R257_2
          say "Unable to find regex 'panic'"
        R257_2:
          $P2 = adverbs['action']
          captob = $P0(captob, "Syntax error", 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["panic"] = captob

          pos = $P1
          local_branch cstack, R258
          delete captscope["panic"]

          goto fail
        R258: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R258_1
          $P0 = find_method mob, 'ws'
          goto R258_2
        R258_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R258_2
          say "Unable to find regex 'ws'"
        R258_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R250
          
          goto fail
        R250: # cut 238
          local_branch cstack, R247
          cutmark = 238
          goto fail

        R247: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R247_1
          $P0 = find_method mob, 'ws'
          goto R247_2
        R247_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R247_2
          say "Unable to find regex 'ws'"
        R247_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R259
          
          goto fail
        R259: # action
          $P1 = adverbs['action']
          if null $P1 goto R260
          $I1 = can $P1, "TOP"
          if $I1 == 0 goto R260
          mpos = pos
          $P1."TOP"(mob)
          goto R260
        R260: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R260_1
          $P0 = find_method mob, 'ws'
          goto R260_2
        R260_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R260_2
          say "Unable to find regex 'ws'"
        R260_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
      .end

## <fun::Grammar::ws>
.namespace ["fun";"Grammar"]
      .sub "ws" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc gpad :unique_reg
          gpad = new 'ResizablePMCArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R: # concat
        R261: # subrule ww
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ww'
          if $I0 == 0 goto R261_1
          $P0 = find_method mob, 'ww'
          goto R261_2
        R261_1:
          $P0 = find_name 'ww'
          unless null $P0 goto R261_2
          say "Unable to find regex 'ww'"
        R261_2:
          captob = $P0(captob)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          unless $P1 < 0 goto fail
          $P1 = pos
          $P1 = getattribute captob, '$.from'
          $P1 = pos
          goto R262
        R262:  # quant 0..Inf none
          local_branch cstack, R262_repeat
          if cutmark != 264 goto fail
          cutmark = 0
          goto fail
        R262_repeat:
          push ustack, pos
          local_branch cstack, R263
          pos = pop ustack
          if cutmark != 0 goto fail
          local_branch cstack, succeed
          if cutmark != 0 goto fail
          cutmark = 264
          goto fail
        R263:  # alt R265, R266
          push ustack, pos
          local_branch cstack, R265
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R266

        R265: # concat
        R267: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "#" goto fail
          pos += 1
          goto R268

        R268: # cclass \N 0..2147483647 (3)
          $I0 = find_cclass 4096, target, pos, lastpos
          rep = $I0 - pos
          ### if rep < 0 goto fail
          ### if rep <= 2147483647 goto R268_1
          ### rep = 2147483647
        R268_1:
          pos += rep
          goto R269
        R269:  # quant 0..1 (3) greedy/none
          push gpad, 0
          local_branch cstack, R269_repeat
          $I0 = pop gpad
          if cutmark != 271 goto fail
          cutmark = 0
          goto fail
        R269_repeat:
          rep = gpad[-1]
          if rep >= 1 goto R269_1
          inc rep
          gpad[-1] = rep
          push ustack, pos
          push ustack, rep
          local_branch cstack, R270
          rep = pop ustack
          pos = pop ustack
          if cutmark != 0 goto fail
          dec rep
        R269_1:
          ### if rep < 0 goto fail
          $I0 = pop gpad
          push ustack, rep
          local_branch cstack, R262_repeat
          rep = pop ustack
          push gpad, rep
          if cutmark != 0 goto fail
          cutmark = 271
          goto fail

        R270: # newline
          $I0 = is_cclass 4096, target, pos
          if $I0 == 0 goto fail
          $S0 = substr target, pos, 2
          inc pos
          if $S0 != "\r\n" goto R269_repeat
          inc pos
          goto R269_repeat
        R266: # cclass \s 1..2147483647 (3)
          $I0 = find_not_cclass 32, target, pos, lastpos
          rep = $I0 - pos
          if rep < 1 goto fail
          ### if rep <= 2147483647 goto R266_1
          ### rep = 2147483647
        R266_1:
          pos += rep
          goto R262_repeat
      .end

## <fun::Grammar::funcname>
.namespace ["fun";"Grammar"]
      .sub "funcname" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc gpad :unique_reg
          gpad = new 'ResizablePMCArray'
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        R: # concat
        R272:  # quant 1..2147483647 (3) greedy/none
          push gpad, 0
          local_branch cstack, R272_repeat
          $I0 = pop gpad
          if cutmark != 275 goto fail
          cutmark = 0
          goto fail
        R272_repeat:
          rep = gpad[-1]
          ### if rep >= 2147483647 goto R272_1
          inc rep
          gpad[-1] = rep
          push ustack, pos
          push ustack, rep
          local_branch cstack, R274
          rep = pop ustack
          pos = pop ustack
          if cutmark != 0 goto fail
          dec rep
        R272_1:
          if rep < 1 goto fail
          $I0 = pop gpad
          push ustack, rep
          local_branch cstack, R273
          rep = pop ustack
          push gpad, rep
          if cutmark != 0 goto fail
          cutmark = 275
          goto fail

        R274:  # alt R276, R277
          push ustack, pos
          local_branch cstack, R276
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R277

        R276:  # alt R278, R279
          push ustack, pos
          local_branch cstack, R278
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R279

        R278:  # alt R280, R281
          push ustack, pos
          local_branch cstack, R280
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R281

        R280: # cclass \w
          if pos >= lastpos goto fail
          $I0 = is_cclass 8192, target, pos
          if $I0 == 0 goto fail
          inc pos
          goto R272_repeat
        R281: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "-" goto fail
          pos += 1
          goto R272_repeat

        R279: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "?" goto fail
          pos += 1
          goto R272_repeat

        R277: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "=" goto fail
          pos += 1
          goto R272_repeat

        R273: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "funcname"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."funcname"(mob)
          goto succeed
      .end

## <fun::Grammar::print>
.namespace ["fun";"Grammar"]
      .sub "print" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        R: # concat
        R282: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "." goto fail
          pos += 1
          goto R283

        R283: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "print"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."print"(mob)
          goto succeed
      .end

## <fun::Grammar::expr>
.namespace ["fun";"Grammar"]
      .sub "expr" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R:  # alt R284, R285
          push ustack, pos
          local_branch cstack, R284
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R285

        R284:  # alt R286, R287
          push ustack, pos
          local_branch cstack, R286
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R287

        R286:  # alt R288, R289
          push ustack, pos
          local_branch cstack, R288
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R289

        R288:  # alt R290, R291
          push ustack, pos
          local_branch cstack, R290
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R291

        R290: # concat
        R292: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R292_1
          $P0 = find_method mob, 'ws'
          goto R292_2
        R292_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R292_2
          say "Unable to find regex 'ws'"
        R292_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R293
          
          goto fail
        R293: # subrule list
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'list'
          if $I0 == 0 goto R293_1
          $P0 = find_method mob, 'list'
          goto R293_2
        R293_1:
          $P0 = find_name 'list'
          unless null $P0 goto R293_2
          say "Unable to find regex 'list'"
        R293_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["list"] = captob

          pos = $P1
          local_branch cstack, R294
          delete captscope["list"]

          goto fail
        R294: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R294_1
          $P0 = find_method mob, 'ws'
          goto R294_2
        R294_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R294_2
          say "Unable to find regex 'ws'"
        R294_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R295
          
          goto fail
        R295: # action
          $P1 = adverbs['action']
          if null $P1 goto R296
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R296
          mpos = pos
          $P1."expr"(mob, "list")
          goto R296
        R296: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R296_1
          $P0 = find_method mob, 'ws'
          goto R296_2
        R296_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R296_2
          say "Unable to find regex 'ws'"
        R296_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R291: # concat
        R297: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R297_1
          $P0 = find_method mob, 'ws'
          goto R297_2
        R297_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R297_2
          say "Unable to find regex 'ws'"
        R297_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R298
          
          goto fail
        R298: # subrule value
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'value'
          if $I0 == 0 goto R298_1
          $P0 = find_method mob, 'value'
          goto R298_2
        R298_1:
          $P0 = find_name 'value'
          unless null $P0 goto R298_2
          say "Unable to find regex 'value'"
        R298_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["value"] = captob

          pos = $P1
          local_branch cstack, R299
          delete captscope["value"]

          goto fail
        R299: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R299_1
          $P0 = find_method mob, 'ws'
          goto R299_2
        R299_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R299_2
          say "Unable to find regex 'ws'"
        R299_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R300
          
          goto fail
        R300: # action
          $P1 = adverbs['action']
          if null $P1 goto R301
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R301
          mpos = pos
          $P1."expr"(mob, "value")
          goto R301
        R301: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R301_1
          $P0 = find_method mob, 'ws'
          goto R301_2
        R301_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R301_2
          say "Unable to find regex 'ws'"
        R301_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R289: # concat
        R302: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R302_1
          $P0 = find_method mob, 'ws'
          goto R302_2
        R302_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R302_2
          say "Unable to find regex 'ws'"
        R302_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R303
          
          goto fail
        R303: # subrule print
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'print'
          if $I0 == 0 goto R303_1
          $P0 = find_method mob, 'print'
          goto R303_2
        R303_1:
          $P0 = find_name 'print'
          unless null $P0 goto R303_2
          say "Unable to find regex 'print'"
        R303_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["print"] = captob

          pos = $P1
          local_branch cstack, R304
          delete captscope["print"]

          goto fail
        R304: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R304_1
          $P0 = find_method mob, 'ws'
          goto R304_2
        R304_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R304_2
          say "Unable to find regex 'ws'"
        R304_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R305
          
          goto fail
        R305: # action
          $P1 = adverbs['action']
          if null $P1 goto R306
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R306
          mpos = pos
          $P1."expr"(mob, "print")
          goto R306
        R306: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R306_1
          $P0 = find_method mob, 'ws'
          goto R306_2
        R306_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R306_2
          say "Unable to find regex 'ws'"
        R306_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R287: # concat
        R307: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R307_1
          $P0 = find_method mob, 'ws'
          goto R307_2
        R307_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R307_2
          say "Unable to find regex 'ws'"
        R307_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R308
          
          goto fail
        R308: # subrule builtins
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'builtins'
          if $I0 == 0 goto R308_1
          $P0 = find_method mob, 'builtins'
          goto R308_2
        R308_1:
          $P0 = find_name 'builtins'
          unless null $P0 goto R308_2
          say "Unable to find regex 'builtins'"
        R308_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["builtins"] = captob

          pos = $P1
          local_branch cstack, R309
          delete captscope["builtins"]

          goto fail
        R309: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R309_1
          $P0 = find_method mob, 'ws'
          goto R309_2
        R309_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R309_2
          say "Unable to find regex 'ws'"
        R309_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R310
          
          goto fail
        R310: # action
          $P1 = adverbs['action']
          if null $P1 goto R311
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R311
          mpos = pos
          $P1."expr"(mob, "builtins")
          goto R311
        R311: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R311_1
          $P0 = find_method mob, 'ws'
          goto R311_2
        R311_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R311_2
          say "Unable to find regex 'ws'"
        R311_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R285: # concat
        R312: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R312_1
          $P0 = find_method mob, 'ws'
          goto R312_2
        R312_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R312_2
          say "Unable to find regex 'ws'"
        R312_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R313
          
          goto fail
        R313: # subrule userfunccall
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'userfunccall'
          if $I0 == 0 goto R313_1
          $P0 = find_method mob, 'userfunccall'
          goto R313_2
        R313_1:
          $P0 = find_name 'userfunccall'
          unless null $P0 goto R313_2
          say "Unable to find regex 'userfunccall'"
        R313_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["userfunccall"] = captob

          pos = $P1
          local_branch cstack, R314
          delete captscope["userfunccall"]

          goto fail
        R314: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R314_1
          $P0 = find_method mob, 'ws'
          goto R314_2
        R314_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R314_2
          say "Unable to find regex 'ws'"
        R314_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R315
          
          goto fail
        R315: # action
          $P1 = adverbs['action']
          if null $P1 goto R316
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R316
          mpos = pos
          $P1."expr"(mob, "userfunccall")
          goto R316
        R316: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R316_1
          $P0 = find_method mob, 'ws'
          goto R316_2
        R316_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R316_2
          say "Unable to find regex 'ws'"
        R316_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
      .end

## <fun::Grammar::func>
.namespace ["fun";"Grammar"]
      .sub "func" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R: # concat
        R317: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R317_1
          $P0 = find_method mob, 'ws'
          goto R317_2
        R317_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R317_2
          say "Unable to find regex 'ws'"
        R317_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R318
          
          goto fail
        R318: # subrule funcname
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'funcname'
          if $I0 == 0 goto R318_1
          $P0 = find_method mob, 'funcname'
          goto R318_2
        R318_1:
          $P0 = find_name 'funcname'
          unless null $P0 goto R318_2
          say "Unable to find regex 'funcname'"
        R318_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["funcname"] = captob

          pos = $P1
          local_branch cstack, R319
          delete captscope["funcname"]

          goto fail
        R319: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R319_1
          $P0 = find_method mob, 'ws'
          goto R319_2
        R319_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R319_2
          say "Unable to find regex 'ws'"
        R319_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R320
          
          goto fail
        R320: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "==" goto fail
          pos += 2
          goto R321

        R321: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R321_1
          $P0 = find_method mob, 'ws'
          goto R321_2
        R321_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R321_2
          say "Unable to find regex 'ws'"
        R321_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R322
          
          goto fail
        R322: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "[" goto fail
          pos += 1
          goto R323

        R323: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R323_1
          $P0 = find_method mob, 'ws'
          goto R323_2
        R323_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R323_2
          say "Unable to find regex 'ws'"
        R323_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R324
          
          goto fail
        R324:  # quant 0..Inf none
          local_branch cstack, R324_repeat
          if cutmark != 327 goto fail
          cutmark = 0
          goto fail
        R324_repeat:
          push ustack, pos
          local_branch cstack, R326
          pos = pop ustack
          if cutmark != 0 goto fail
          local_branch cstack, R325
          if cutmark != 0 goto fail
          cutmark = 327
          goto fail
        R326: # subrule expr
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'expr'
          if $I0 == 0 goto R326_1
          $P0 = find_method mob, 'expr'
          goto R326_2
        R326_1:
          $P0 = find_name 'expr'
          unless null $P0 goto R326_2
          say "Unable to find regex 'expr'"
        R326_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
                    $I0 = defined captscope["expr"]
          if $I0 goto R326_cgen
          $P0 = new 'ResizablePMCArray'
          captscope["expr"] = $P0
          local_branch cstack, R326_cgen
          delete captscope["expr"]
          goto fail
        R326_cgen:

          $P2 = captscope["expr"]
          push $P2, captob

          pos = $P1
          local_branch cstack, R326_3
          $P2 = captscope["expr"]
          $P2 = pop $P2

          goto fail
        R326_3:
          pos = $P1
          $P1 = getattribute captob, '&!corou'
          if null $P1 goto R324_repeat
          push ustack, captob
          local_branch cstack, R324_repeat
          captob = pop ustack
          if cutmark != 0 goto fail
          captob.'next'()
          $P1 = getattribute captob, '$.pos'
          if $P1 >= 0 goto R326_3
          if $P1 <= -3 goto fail_match
          goto fail

        R325: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R325_1
          $P0 = find_method mob, 'ws'
          goto R325_2
        R325_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R325_2
          say "Unable to find regex 'ws'"
        R325_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R328
          
          goto fail
        R328: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "]" goto fail
          pos += 1
          goto R329

        R329: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R329_1
          $P0 = find_method mob, 'ws'
          goto R329_2
        R329_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R329_2
          say "Unable to find regex 'ws'"
        R329_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R330
          
          goto fail
        R330: # action
          $P1 = adverbs['action']
          if null $P1 goto R331
          $I1 = can $P1, "func"
          if $I1 == 0 goto R331
          mpos = pos
          $P1."func"(mob)
          goto R331
        R331: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R331_1
          $P0 = find_method mob, 'ws'
          goto R331_2
        R331_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R331_2
          say "Unable to find regex 'ws'"
        R331_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
      .end

## <fun::Grammar::list>
.namespace ["fun";"Grammar"]
      .sub "list" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R: # concat
        R332: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R332_1
          $P0 = find_method mob, 'ws'
          goto R332_2
        R332_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R332_2
          say "Unable to find regex 'ws'"
        R332_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R333
          
          goto fail
        R333: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "[" goto fail
          pos += 1
          goto R334

        R334: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R334_1
          $P0 = find_method mob, 'ws'
          goto R334_2
        R334_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R334_2
          say "Unable to find regex 'ws'"
        R334_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R335
          
          goto fail
        R335:  # quant 0..Inf none
          local_branch cstack, R335_repeat
          if cutmark != 338 goto fail
          cutmark = 0
          goto fail
        R335_repeat:
          push ustack, pos
          local_branch cstack, R337
          pos = pop ustack
          if cutmark != 0 goto fail
          local_branch cstack, R336
          if cutmark != 0 goto fail
          cutmark = 338
          goto fail
        R337: # subrule expr
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'expr'
          if $I0 == 0 goto R337_1
          $P0 = find_method mob, 'expr'
          goto R337_2
        R337_1:
          $P0 = find_name 'expr'
          unless null $P0 goto R337_2
          say "Unable to find regex 'expr'"
        R337_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
                    $I0 = defined captscope["expr"]
          if $I0 goto R337_cgen
          $P0 = new 'ResizablePMCArray'
          captscope["expr"] = $P0
          local_branch cstack, R337_cgen
          delete captscope["expr"]
          goto fail
        R337_cgen:

          $P2 = captscope["expr"]
          push $P2, captob

          pos = $P1
          local_branch cstack, R337_3
          $P2 = captscope["expr"]
          $P2 = pop $P2

          goto fail
        R337_3:
          pos = $P1
          $P1 = getattribute captob, '&!corou'
          if null $P1 goto R335_repeat
          push ustack, captob
          local_branch cstack, R335_repeat
          captob = pop ustack
          if cutmark != 0 goto fail
          captob.'next'()
          $P1 = getattribute captob, '$.pos'
          if $P1 >= 0 goto R337_3
          if $P1 <= -3 goto fail_match
          goto fail

        R336: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R336_1
          $P0 = find_method mob, 'ws'
          goto R336_2
        R336_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R336_2
          say "Unable to find regex 'ws'"
        R336_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R339
          
          goto fail
        R339: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "]" goto fail
          pos += 1
          goto R340

        R340: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R340_1
          $P0 = find_method mob, 'ws'
          goto R340_2
        R340_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R340_2
          say "Unable to find regex 'ws'"
        R340_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R341
          
          goto fail
        R341: # action
          $P1 = adverbs['action']
          if null $P1 goto R342
          $I1 = can $P1, "list"
          if $I1 == 0 goto R342
          mpos = pos
          $P1."list"(mob)
          goto R342
        R342: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R342_1
          $P0 = find_method mob, 'ws'
          goto R342_2
        R342_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R342_2
          say "Unable to find regex 'ws'"
        R342_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
      .end

## <fun::Grammar::value>
.namespace ["fun";"Grammar"]
      .sub "value" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R:  # alt R343, R344
          push ustack, pos
          local_branch cstack, R343
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R344

        R343:  # alt R345, R346
          push ustack, pos
          local_branch cstack, R345
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R346

        R345:  # alt R347, R348
          push ustack, pos
          local_branch cstack, R347
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R348

        R347: # concat
        R349: # subrule float
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'float'
          if $I0 == 0 goto R349_1
          $P0 = find_method mob, 'float'
          goto R349_2
        R349_1:
          $P0 = find_name 'float'
          unless null $P0 goto R349_2
          say "Unable to find regex 'float'"
        R349_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["float"] = captob

          pos = $P1
          local_branch cstack, R350
          delete captscope["float"]

          goto fail
        R350: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "value"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."value"(mob, "float")
          goto succeed
        R348: # concat
        R351: # subrule integer
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'integer'
          if $I0 == 0 goto R351_1
          $P0 = find_method mob, 'integer'
          goto R351_2
        R351_1:
          $P0 = find_name 'integer'
          unless null $P0 goto R351_2
          say "Unable to find regex 'integer'"
        R351_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["integer"] = captob

          pos = $P1
          local_branch cstack, R352
          delete captscope["integer"]

          goto fail
        R352: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "value"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."value"(mob, "integer")
          goto succeed
        R346: # concat
        R353: # subrule string
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'string'
          if $I0 == 0 goto R353_1
          $P0 = find_method mob, 'string'
          goto R353_2
        R353_1:
          $P0 = find_name 'string'
          unless null $P0 goto R353_2
          say "Unable to find regex 'string'"
        R353_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["string"] = captob

          pos = $P1
          local_branch cstack, R354
          delete captscope["string"]

          goto fail
        R354: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "value"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."value"(mob, "string")
          goto succeed
        R344: # concat
        R355: # subrule bool
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'bool'
          if $I0 == 0 goto R355_1
          $P0 = find_method mob, 'bool'
          goto R355_2
        R355_1:
          $P0 = find_name 'bool'
          unless null $P0 goto R355_2
          say "Unable to find regex 'bool'"
        R355_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["bool"] = captob

          pos = $P1
          local_branch cstack, R356
          delete captscope["bool"]

          goto fail
        R356: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "value"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."value"(mob, "bool")
          goto succeed
      .end

## <fun::Grammar::integer>
.namespace ["fun";"Grammar"]
      .sub "integer" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc gpad :unique_reg
          gpad = new 'ResizablePMCArray'
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        R: # concat
        R357:  # quant 0..1 (3) greedy/none
          push gpad, 0
          local_branch cstack, R357_repeat
          $I0 = pop gpad
          if cutmark != 360 goto fail
          cutmark = 0
          goto fail
        R357_repeat:
          rep = gpad[-1]
          if rep >= 1 goto R357_1
          inc rep
          gpad[-1] = rep
          push ustack, pos
          push ustack, rep
          local_branch cstack, R359
          rep = pop ustack
          pos = pop ustack
          if cutmark != 0 goto fail
          dec rep
        R357_1:
          ### if rep < 0 goto fail
          $I0 = pop gpad
          push ustack, rep
          local_branch cstack, R358
          rep = pop ustack
          push gpad, rep
          if cutmark != 0 goto fail
          cutmark = 360
          goto fail

        R359: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "-" goto fail
          pos += 1
          goto R357_repeat

        R358: # cclass \d 1..2147483647 (3)
          $I0 = find_not_cclass 8, target, pos, lastpos
          rep = $I0 - pos
          if rep < 1 goto fail
          ### if rep <= 2147483647 goto R358_1
          ### rep = 2147483647
        R358_1:
          pos += rep
          goto R361
        R361: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "integer"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."integer"(mob)
          goto succeed
      .end

## <fun::Grammar::float>
.namespace ["fun";"Grammar"]
      .sub "float" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc gpad :unique_reg
          gpad = new 'ResizablePMCArray'
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        R: # concat
        R362:  # quant 0..1 (3) greedy/none
          push gpad, 0
          local_branch cstack, R362_repeat
          $I0 = pop gpad
          if cutmark != 365 goto fail
          cutmark = 0
          goto fail
        R362_repeat:
          rep = gpad[-1]
          if rep >= 1 goto R362_1
          inc rep
          gpad[-1] = rep
          push ustack, pos
          push ustack, rep
          local_branch cstack, R364
          rep = pop ustack
          pos = pop ustack
          if cutmark != 0 goto fail
          dec rep
        R362_1:
          ### if rep < 0 goto fail
          $I0 = pop gpad
          push ustack, rep
          local_branch cstack, R363
          rep = pop ustack
          push gpad, rep
          if cutmark != 0 goto fail
          cutmark = 365
          goto fail

        R364: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "-" goto fail
          pos += 1
          goto R362_repeat

        R363: # cclass \d 1..2147483647 (3)
          $I0 = find_not_cclass 8, target, pos, lastpos
          rep = $I0 - pos
          if rep < 1 goto fail
          ### if rep <= 2147483647 goto R363_1
          ### rep = 2147483647
        R363_1:
          pos += rep
          goto R366
        R366: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "." goto fail
          pos += 1
          goto R367

        R367: # cclass \d 1..2147483647 (3)
          $I0 = find_not_cclass 8, target, pos, lastpos
          rep = $I0 - pos
          if rep < 1 goto fail
          ### if rep <= 2147483647 goto R367_1
          ### rep = 2147483647
        R367_1:
          pos += rep
          goto R368
        R368: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "float"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."float"(mob)
          goto succeed
      .end

## <fun::Grammar::bool>
.namespace ["fun";"Grammar"]
      .sub "bool" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        R: # concat
        R370:  # group 369
          local_branch cstack, R372
          if cutmark != 369 goto fail
          cutmark = 0
          goto fail

        R372: # concat
        R373:  # alt R375, R376
          push ustack, pos
          local_branch cstack, R375
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R376

        R375: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "true" goto fail
          pos += 4
          goto R374

        R376: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "false" goto fail
          pos += 5
          goto R374

        R374: # cut 369
          local_branch cstack, R371
          cutmark = 369
          goto fail

        R371: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "bool"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."bool"(mob)
          goto succeed
      .end

## <fun::Grammar::string>
.namespace ["fun";"Grammar"]
      .sub "string" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R: # concat
        R378:  # group 377
          local_branch cstack, R380
          if cutmark != 377 goto fail
          cutmark = 0
          goto fail

        R380: # concat
        R381:  # alt R383, R384
          push ustack, pos
          local_branch cstack, R383
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R384

        R383: # concat
        R385: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "'" goto fail
          pos += 1
          goto R386

        R386: # subrule string_literal
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'string_literal'
          if $I0 == 0 goto R386_1
          $P0 = find_method mob, 'string_literal'
          goto R386_2
        R386_1:
          $P0 = find_name 'string_literal'
          unless null $P0 goto R386_2
          say "Unable to find regex 'string_literal'"
        R386_2:
          $P2 = adverbs['action']
          captob = $P0(captob, "'", 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["string_literal"] = captob

          pos = $P1
          local_branch cstack, R387
          delete captscope["string_literal"]

          goto fail
        R387: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "'" goto fail
          pos += 1
          goto R382

        R384: # concat
        R388: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "\"" goto fail
          pos += 1
          goto R389

        R389: # subrule string_literal
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'string_literal'
          if $I0 == 0 goto R389_1
          $P0 = find_method mob, 'string_literal'
          goto R389_2
        R389_1:
          $P0 = find_name 'string_literal'
          unless null $P0 goto R389_2
          say "Unable to find regex 'string_literal'"
        R389_2:
          $P2 = adverbs['action']
          captob = $P0(captob, "\"", 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["string_literal"] = captob

          pos = $P1
          local_branch cstack, R390
          delete captscope["string_literal"]

          goto fail
        R390: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "\"" goto fail
          pos += 1
          goto R382

        R382: # cut 377
          local_branch cstack, R379
          cutmark = 377
          goto fail

        R379: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "string"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."string"(mob)
          goto succeed
      .end

## <fun::Grammar::builtins>
.namespace ["fun";"Grammar"]
      .sub "builtins" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc ustack :unique_reg
          ustack = new 'ResizablePMCArray'
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        R:  # alt R391, R392
          push ustack, pos
          local_branch cstack, R391
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R392

        R391:  # alt R393, R394
          push ustack, pos
          local_branch cstack, R393
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R394

        R393:  # alt R395, R396
          push ustack, pos
          local_branch cstack, R395
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R396

        R395:  # alt R397, R398
          push ustack, pos
          local_branch cstack, R397
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R398

        R397:  # alt R399, R400
          push ustack, pos
          local_branch cstack, R399
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R400

        R399:  # alt R401, R402
          push ustack, pos
          local_branch cstack, R401
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R402

        R401:  # alt R403, R404
          push ustack, pos
          local_branch cstack, R403
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R404

        R403:  # alt R405, R406
          push ustack, pos
          local_branch cstack, R405
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R406

        R405:  # alt R407, R408
          push ustack, pos
          local_branch cstack, R407
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R408

        R407:  # alt R409, R410
          push ustack, pos
          local_branch cstack, R409
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R410

        R409:  # alt R411, R412
          push ustack, pos
          local_branch cstack, R411
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R412

        R411:  # alt R413, R414
          push ustack, pos
          local_branch cstack, R413
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R414

        R413:  # alt R415, R416
          push ustack, pos
          local_branch cstack, R415
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R416

        R415:  # alt R417, R418
          push ustack, pos
          local_branch cstack, R417
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R418

        R417:  # alt R419, R420
          push ustack, pos
          local_branch cstack, R419
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R420

        R419:  # alt R421, R422
          push ustack, pos
          local_branch cstack, R421
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R422

        R421:  # alt R423, R424
          push ustack, pos
          local_branch cstack, R423
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R424

        R423:  # alt R425, R426
          push ustack, pos
          local_branch cstack, R425
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R426

        R425:  # alt R427, R428
          push ustack, pos
          local_branch cstack, R427
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R428

        R427:  # alt R429, R430
          push ustack, pos
          local_branch cstack, R429
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R430

        R429:  # alt R431, R432
          push ustack, pos
          local_branch cstack, R431
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R432

        R431:  # alt R433, R434
          push ustack, pos
          local_branch cstack, R433
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R434

        R433:  # alt R435, R436
          push ustack, pos
          local_branch cstack, R435
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R436

        R435:  # alt R437, R438
          push ustack, pos
          local_branch cstack, R437
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R438

        R437:  # alt R439, R440
          push ustack, pos
          local_branch cstack, R439
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R440

        R439:  # alt R441, R442
          push ustack, pos
          local_branch cstack, R441
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R442

        R441:  # alt R443, R444
          push ustack, pos
          local_branch cstack, R443
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R444

        R443:  # alt R445, R446
          push ustack, pos
          local_branch cstack, R445
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R446

        R445:  # alt R447, R448
          push ustack, pos
          local_branch cstack, R447
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R448

        R447:  # alt R449, R450
          push ustack, pos
          local_branch cstack, R449
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R450

        R449:  # alt R451, R452
          push ustack, pos
          local_branch cstack, R451
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R452

        R451:  # alt R453, R454
          push ustack, pos
          local_branch cstack, R453
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R454

        R453:  # alt R455, R456
          push ustack, pos
          local_branch cstack, R455
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R456

        R455:  # alt R457, R458
          push ustack, pos
          local_branch cstack, R457
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R458

        R457:  # alt R459, R460
          push ustack, pos
          local_branch cstack, R459
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R460

        R459:  # alt R461, R462
          push ustack, pos
          local_branch cstack, R461
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R462

        R461:  # alt R463, R464
          push ustack, pos
          local_branch cstack, R463
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R464

        R463:  # alt R465, R466
          push ustack, pos
          local_branch cstack, R465
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R466

        R465:  # alt R467, R468
          push ustack, pos
          local_branch cstack, R467
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R468

        R467:  # alt R469, R470
          push ustack, pos
          local_branch cstack, R469
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R470

        R469:  # alt R471, R472
          push ustack, pos
          local_branch cstack, R471
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R472

        R471:  # alt R473, R474
          push ustack, pos
          local_branch cstack, R473
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R474

        R473:  # alt R475, R476
          push ustack, pos
          local_branch cstack, R475
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R476

        R475:  # alt R477, R478
          push ustack, pos
          local_branch cstack, R477
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R478

        R477:  # alt R479, R480
          push ustack, pos
          local_branch cstack, R479
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R480

        R479:  # alt R481, R482
          push ustack, pos
          local_branch cstack, R481
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R482

        R481:  # alt R483, R484
          push ustack, pos
          local_branch cstack, R483
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R484

        R483:  # alt R485, R486
          push ustack, pos
          local_branch cstack, R485
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R486

        R485:  # alt R487, R488
          push ustack, pos
          local_branch cstack, R487
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R488

        R487:  # alt R489, R490
          push ustack, pos
          local_branch cstack, R489
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R490

        R489:  # alt R491, R492
          push ustack, pos
          local_branch cstack, R491
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R492

        R491:  # alt R493, R494
          push ustack, pos
          local_branch cstack, R493
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R494

        R493:  # alt R495, R496
          push ustack, pos
          local_branch cstack, R495
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R496

        R495:  # alt R497, R498
          push ustack, pos
          local_branch cstack, R497
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R498

        R497:  # alt R499, R500
          push ustack, pos
          local_branch cstack, R499
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R500

        R499:  # alt R501, R502
          push ustack, pos
          local_branch cstack, R501
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R502

        R501:  # alt R503, R504
          push ustack, pos
          local_branch cstack, R503
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R504

        R503:  # alt R505, R506
          push ustack, pos
          local_branch cstack, R505
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R506

        R505:  # alt R507, R508
          push ustack, pos
          local_branch cstack, R507
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R508

        R507:  # alt R509, R510
          push ustack, pos
          local_branch cstack, R509
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R510

        R509:  # alt R511, R512
          push ustack, pos
          local_branch cstack, R511
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R512

        R511:  # alt R513, R514
          push ustack, pos
          local_branch cstack, R513
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R514

        R513:  # alt R515, R516
          push ustack, pos
          local_branch cstack, R515
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R516

        R515:  # alt R517, R518
          push ustack, pos
          local_branch cstack, R517
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R518

        R517:  # alt R519, R520
          push ustack, pos
          local_branch cstack, R519
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R520

        R519:  # alt R521, R522
          push ustack, pos
          local_branch cstack, R521
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R522

        R521:  # alt R523, R524
          push ustack, pos
          local_branch cstack, R523
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R524

        R523:  # alt R525, R526
          push ustack, pos
          local_branch cstack, R525
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R526

        R525:  # alt R527, R528
          push ustack, pos
          local_branch cstack, R527
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R528

        R527:  # alt R529, R530
          push ustack, pos
          local_branch cstack, R529
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R530

        R529:  # alt R531, R532
          push ustack, pos
          local_branch cstack, R531
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R532

        R531:  # alt R533, R534
          push ustack, pos
          local_branch cstack, R533
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R534

        R533:  # alt R535, R536
          push ustack, pos
          local_branch cstack, R535
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R536

        R535:  # alt R537, R538
          push ustack, pos
          local_branch cstack, R537
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R538

        R537:  # alt R539, R540
          push ustack, pos
          local_branch cstack, R539
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R540

        R539:  # alt R541, R542
          push ustack, pos
          local_branch cstack, R541
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R542

        R541:  # alt R543, R544
          push ustack, pos
          local_branch cstack, R543
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R544

        R543:  # alt R545, R546
          push ustack, pos
          local_branch cstack, R545
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R546

        R545:  # alt R547, R548
          push ustack, pos
          local_branch cstack, R547
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R548

        R547:  # alt R549, R550
          push ustack, pos
          local_branch cstack, R549
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R550

        R549:  # alt R551, R552
          push ustack, pos
          local_branch cstack, R551
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R552

        R551:  # alt R553, R554
          push ustack, pos
          local_branch cstack, R553
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R554

        R553:  # alt R555, R556
          push ustack, pos
          local_branch cstack, R555
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R556

        R555:  # alt R557, R558
          push ustack, pos
          local_branch cstack, R557
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R558

        R557:  # alt R559, R560
          push ustack, pos
          local_branch cstack, R559
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R560

        R559:  # alt R561, R562
          push ustack, pos
          local_branch cstack, R561
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R562

        R561:  # alt R563, R564
          push ustack, pos
          local_branch cstack, R563
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R564

        R563:  # alt R565, R566
          push ustack, pos
          local_branch cstack, R565
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R566

        R565:  # alt R567, R568
          push ustack, pos
          local_branch cstack, R567
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R568

        R567:  # alt R569, R570
          push ustack, pos
          local_branch cstack, R569
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R570

        R569:  # alt R571, R572
          push ustack, pos
          local_branch cstack, R571
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R572

        R571:  # alt R573, R574
          push ustack, pos
          local_branch cstack, R573
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R574

        R573:  # alt R575, R576
          push ustack, pos
          local_branch cstack, R575
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R576

        R575:  # alt R577, R578
          push ustack, pos
          local_branch cstack, R577
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R578

        R577:  # alt R579, R580
          push ustack, pos
          local_branch cstack, R579
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R580

        R579:  # alt R581, R582
          push ustack, pos
          local_branch cstack, R581
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R582

        R581:  # alt R583, R584
          push ustack, pos
          local_branch cstack, R583
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R584

        R583:  # alt R585, R586
          push ustack, pos
          local_branch cstack, R585
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R586

        R585:  # alt R587, R588
          push ustack, pos
          local_branch cstack, R587
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R588

        R587:  # alt R589, R590
          push ustack, pos
          local_branch cstack, R589
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R590

        R589:  # alt R591, R592
          push ustack, pos
          local_branch cstack, R591
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R592

        R591:  # alt R593, R594
          push ustack, pos
          local_branch cstack, R593
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R594

        R593:  # alt R595, R596
          push ustack, pos
          local_branch cstack, R595
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R596

        R595:  # alt R597, R598
          push ustack, pos
          local_branch cstack, R597
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R598

        R597:  # alt R599, R600
          push ustack, pos
          local_branch cstack, R599
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R600

        R599:  # alt R601, R602
          push ustack, pos
          local_branch cstack, R601
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R602

        R601:  # alt R603, R604
          push ustack, pos
          local_branch cstack, R603
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R604

        R603:  # alt R605, R606
          push ustack, pos
          local_branch cstack, R605
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R606

        R605:  # alt R607, R608
          push ustack, pos
          local_branch cstack, R607
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R608

        R607:  # alt R609, R610
          push ustack, pos
          local_branch cstack, R609
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R610

        R609:  # alt R611, R612
          push ustack, pos
          local_branch cstack, R611
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R612

        R611:  # alt R613, R614
          push ustack, pos
          local_branch cstack, R613
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R614

        R613:  # alt R615, R616
          push ustack, pos
          local_branch cstack, R615
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R616

        R615:  # alt R617, R618
          push ustack, pos
          local_branch cstack, R617
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R618

        R617:  # alt R619, R620
          push ustack, pos
          local_branch cstack, R619
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R620

        R619:  # alt R621, R622
          push ustack, pos
          local_branch cstack, R621
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R622

        R621:  # alt R623, R624
          push ustack, pos
          local_branch cstack, R623
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R624

        R623:  # alt R625, R626
          push ustack, pos
          local_branch cstack, R625
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R626

        R625:  # alt R627, R628
          push ustack, pos
          local_branch cstack, R627
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R628

        R627:  # alt R629, R630
          push ustack, pos
          local_branch cstack, R629
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R630

        R629:  # alt R631, R632
          push ustack, pos
          local_branch cstack, R631
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R632

        R631:  # alt R633, R634
          push ustack, pos
          local_branch cstack, R633
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R634

        R633:  # alt R635, R636
          push ustack, pos
          local_branch cstack, R635
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R636

        R635:  # alt R637, R638
          push ustack, pos
          local_branch cstack, R637
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R638

        R637:  # alt R639, R640
          push ustack, pos
          local_branch cstack, R639
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R640

        R639:  # alt R641, R642
          push ustack, pos
          local_branch cstack, R641
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R642

        R641:  # alt R643, R644
          push ustack, pos
          local_branch cstack, R643
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R644

        R643:  # alt R645, R646
          push ustack, pos
          local_branch cstack, R645
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R646

        R645:  # alt R647, R648
          push ustack, pos
          local_branch cstack, R647
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R648

        R647:  # alt R649, R650
          push ustack, pos
          local_branch cstack, R649
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R650

        R649:  # alt R651, R652
          push ustack, pos
          local_branch cstack, R651
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R652

        R651:  # alt R653, R654
          push ustack, pos
          local_branch cstack, R653
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R654

        R653:  # alt R655, R656
          push ustack, pos
          local_branch cstack, R655
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R656

        R655:  # alt R657, R658
          push ustack, pos
          local_branch cstack, R657
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R658

        R657:  # alt R659, R660
          push ustack, pos
          local_branch cstack, R659
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R660

        R659:  # alt R661, R662
          push ustack, pos
          local_branch cstack, R661
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R662

        R661:  # alt R663, R664
          push ustack, pos
          local_branch cstack, R663
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R664

        R663:  # alt R665, R666
          push ustack, pos
          local_branch cstack, R665
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R666

        R665:  # alt R667, R668
          push ustack, pos
          local_branch cstack, R667
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R668

        R667:  # alt R669, R670
          push ustack, pos
          local_branch cstack, R669
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R670

        R669:  # alt R671, R672
          push ustack, pos
          local_branch cstack, R671
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R672

        R671:  # alt R673, R674
          push ustack, pos
          local_branch cstack, R673
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R674

        R673:  # alt R675, R676
          push ustack, pos
          local_branch cstack, R675
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R676

        R675:  # alt R677, R678
          push ustack, pos
          local_branch cstack, R677
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R678

        R677:  # alt R679, R680
          push ustack, pos
          local_branch cstack, R679
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R680

        R679:  # alt R681, R682
          push ustack, pos
          local_branch cstack, R681
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R682

        R681:  # alt R683, R684
          push ustack, pos
          local_branch cstack, R683
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R684

        R683:  # alt R685, R686
          push ustack, pos
          local_branch cstack, R685
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R686

        R685:  # alt R687, R688
          push ustack, pos
          local_branch cstack, R687
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R688

        R687:  # alt R689, R690
          push ustack, pos
          local_branch cstack, R689
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R690

        R689:  # alt R691, R692
          push ustack, pos
          local_branch cstack, R691
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R692

        R691:  # alt R693, R694
          push ustack, pos
          local_branch cstack, R693
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R694

        R693:  # alt R695, R696
          push ustack, pos
          local_branch cstack, R695
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R696

        R695:  # alt R697, R698
          push ustack, pos
          local_branch cstack, R697
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R698

        R697:  # alt R699, R700
          push ustack, pos
          local_branch cstack, R699
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R700

        R699:  # alt R701, R702
          push ustack, pos
          local_branch cstack, R701
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R702

        R701:  # alt R703, R704
          push ustack, pos
          local_branch cstack, R703
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R704

        R703:  # alt R705, R706
          push ustack, pos
          local_branch cstack, R705
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R706

        R705:  # alt R707, R708
          push ustack, pos
          local_branch cstack, R707
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R708

        R707:  # alt R709, R710
          push ustack, pos
          local_branch cstack, R709
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R710

        R709:  # alt R711, R712
          push ustack, pos
          local_branch cstack, R711
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R712

        R711:  # alt R713, R714
          push ustack, pos
          local_branch cstack, R713
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R714

        R713:  # alt R715, R716
          push ustack, pos
          local_branch cstack, R715
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R716

        R715:  # alt R717, R718
          push ustack, pos
          local_branch cstack, R717
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R718

        R717:  # alt R719, R720
          push ustack, pos
          local_branch cstack, R719
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R720

        R719:  # alt R721, R722
          push ustack, pos
          local_branch cstack, R721
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R722

        R721:  # alt R723, R724
          push ustack, pos
          local_branch cstack, R723
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R724

        R723:  # alt R725, R726
          push ustack, pos
          local_branch cstack, R725
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R726

        R725:  # alt R727, R728
          push ustack, pos
          local_branch cstack, R727
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R728

        R727:  # alt R729, R730
          push ustack, pos
          local_branch cstack, R729
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R730

        R729:  # alt R731, R732
          push ustack, pos
          local_branch cstack, R731
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R732

        R731:  # alt R733, R734
          push ustack, pos
          local_branch cstack, R733
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R734

        R733:  # alt R735, R736
          push ustack, pos
          local_branch cstack, R735
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R736

        R735:  # alt R737, R738
          push ustack, pos
          local_branch cstack, R737
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R738

        R737:  # alt R739, R740
          push ustack, pos
          local_branch cstack, R739
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R740

        R739:  # alt R741, R742
          push ustack, pos
          local_branch cstack, R741
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R742

        R741:  # alt R743, R744
          push ustack, pos
          local_branch cstack, R743
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R744

        R743:  # alt R745, R746
          push ustack, pos
          local_branch cstack, R745
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R746

        R745:  # alt R747, R748
          push ustack, pos
          local_branch cstack, R747
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R748

        R747:  # alt R749, R750
          push ustack, pos
          local_branch cstack, R749
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R750

        R749:  # alt R751, R752
          push ustack, pos
          local_branch cstack, R751
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R752

        R751:  # alt R753, R754
          push ustack, pos
          local_branch cstack, R753
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R754

        R753:  # alt R755, R756
          push ustack, pos
          local_branch cstack, R755
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R756

        R755:  # alt R757, R758
          push ustack, pos
          local_branch cstack, R757
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R758

        R757:  # alt R759, R760
          push ustack, pos
          local_branch cstack, R759
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R760

        R759:  # alt R761, R762
          push ustack, pos
          local_branch cstack, R761
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R762

        R761:  # alt R763, R764
          push ustack, pos
          local_branch cstack, R763
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R764

        R763:  # alt R765, R766
          push ustack, pos
          local_branch cstack, R765
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R766

        R765:  # alt R767, R768
          push ustack, pos
          local_branch cstack, R767
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R768

        R767:  # alt R769, R770
          push ustack, pos
          local_branch cstack, R769
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R770

        R769:  # alt R771, R772
          push ustack, pos
          local_branch cstack, R771
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R772

        R771:  # alt R773, R774
          push ustack, pos
          local_branch cstack, R773
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R774

        R773:  # alt R775, R776
          push ustack, pos
          local_branch cstack, R775
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R776

        R775:  # alt R777, R778
          push ustack, pos
          local_branch cstack, R777
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R778

        R777:  # alt R779, R780
          push ustack, pos
          local_branch cstack, R779
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R780

        R779:  # alt R781, R782
          push ustack, pos
          local_branch cstack, R781
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R782

        R781:  # alt R783, R784
          push ustack, pos
          local_branch cstack, R783
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R784

        R783:  # alt R785, R786
          push ustack, pos
          local_branch cstack, R785
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R786

        R785:  # alt R787, R788
          push ustack, pos
          local_branch cstack, R787
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R788

        R787:  # alt R789, R790
          push ustack, pos
          local_branch cstack, R789
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R790

        R789:  # alt R791, R792
          push ustack, pos
          local_branch cstack, R791
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R792

        R791:  # alt R793, R794
          push ustack, pos
          local_branch cstack, R793
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R794

        R793: # concat
        R795: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "++" goto fail
          pos += 2
          goto R796

        R796: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R794: # concat
        R797: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "--" goto fail
          pos += 2
          goto R798

        R798: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R792: # concat
        R799: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "+" goto fail
          pos += 1
          goto R800

        R800: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R790: # concat
        R801: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "-" goto fail
          pos += 1
          goto R802

        R802: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R788: # concat
        R803: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "*" goto fail
          pos += 1
          goto R804

        R804: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R786: # concat
        R805: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "/" goto fail
          pos += 1
          goto R806

        R806: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R784: # concat
        R807: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "<=" goto fail
          pos += 2
          goto R808

        R808: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R782: # concat
        R809: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != ">=" goto fail
          pos += 2
          goto R810

        R810: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R780: # concat
        R811: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "!=" goto fail
          pos += 2
          goto R812

        R812: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R778: # concat
        R813: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "=" goto fail
          pos += 1
          goto R814

        R814: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R776: # concat
        R815: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "<" goto fail
          pos += 1
          goto R816

        R816: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R774: # concat
        R817: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != ">" goto fail
          pos += 1
          goto R818

        R818: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R772: # concat
        R819: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "or" goto fail
          pos += 2
          goto R820

        R820: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R770: # concat
        R821: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "and" goto fail
          pos += 3
          goto R822

        R822: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R768: # concat
        R823: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "xor" goto fail
          pos += 3
          goto R824

        R824: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R766: # concat
        R825: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "div" goto fail
          pos += 3
          goto R826

        R826: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R764: # concat
        R827: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "rem" goto fail
          pos += 3
          goto R828

        R828: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R762: # concat
        R829: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "mod" goto fail
          pos += 3
          goto R830

        R830: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R760: # concat
        R831: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "cmp" goto fail
          pos += 3
          goto R832

        R832: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R758: # concat
        R833: # literal
          $I0 = pos + 13
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 13
          
          if $S0 != "setundeferror" goto fail
          pos += 13
          goto R834

        R834: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R756: # concat
        R835: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "undeferror" goto fail
          pos += 10
          goto R836

        R836: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R754: # concat
        R837: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "fputstring" goto fail
          pos += 10
          goto R838

        R838: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R752: # concat
        R839: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "condlinrec" goto fail
          pos += 10
          goto R840

        R840: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R750: # concat
        R841: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "treegenrec" goto fail
          pos += 10
          goto R842

        R842: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R748: # concat
        R843: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "helpdetail" goto fail
          pos += 10
          goto R844

        R844: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R746: # concat
        R845: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "setautoput" goto fail
          pos += 10
          goto R846

        R846: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R744: # concat
        R847: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "rolldownd" goto fail
          pos += 9
          goto R848

        R848: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R742: # concat
        R849: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "localtime" goto fail
          pos += 9
          goto R850

        R850: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R740: # concat
        R851: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "fputchars" goto fail
          pos += 9
          goto R852

        R852: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R738: # concat
        R853: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "construct" goto fail
          pos += 9
          goto R854

        R854: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R736: # concat
        R855: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "ifinteger" goto fail
          pos += 9
          goto R856

        R856: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R734: # concat
        R857: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "iflogical" goto fail
          pos += 9
          goto R858

        R858: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R732: # concat
        R859: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "rolldown" goto fail
          pos += 8
          goto R860

        R860: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R730: # concat
        R861: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "strftime" goto fail
          pos += 8
          goto R862

        R862: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R728: # concat
        R863: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "enconcat" goto fail
          pos += 8
          goto R864

        R864: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R726: # concat
        R865: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "ifstring" goto fail
          pos += 8
          goto R866

        R866: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R724: # concat
        R867: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "tostring" goto fail
          pos += 8
          goto R868

        R868: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R722: # concat
        R869: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "treestep" goto fail
          pos += 8
          goto R870

        R870: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R720: # concat
        R871: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "putchars" goto fail
          pos += 8
          goto R872

        R872: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R718: # concat
        R873: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "setsize" goto fail
          pos += 7
          goto R874

        R874: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R716: # concat
        R875: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "autoput" goto fail
          pos += 7
          goto R876

        R876: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R714: # concat
        R877: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "rollupd" goto fail
          pos += 7
          goto R878

        R878: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R712: # concat
        R879: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "rotated" goto fail
          pos += 7
          goto R880

        R880: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R710: # concat
        R881: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "formatf" goto fail
          pos += 7
          goto R882

        R882: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R708: # concat
        R883: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "fremove" goto fail
          pos += 7
          goto R884

        R884: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R706: # concat
        R885: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "frename" goto fail
          pos += 7
          goto R886

        R886: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R704: # concat
        R887: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "unstack" goto fail
          pos += 7
          goto R888

        R888: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R702: # concat
        R889: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "unswons" goto fail
          pos += 7
          goto R890

        R890: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R700: # concat
        R891: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "integer" goto fail
          pos += 7
          goto R892

        R892: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R698: # concat
        R893: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "logical" goto fail
          pos += 7
          goto R894

        R894: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R696: # concat
        R895: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "nullary" goto fail
          pos += 7
          goto R896

        R896: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R694: # concat
        R897: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "ternary" goto fail
          pos += 7
          goto R898

        R898: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R692: # concat
        R899: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "iffloat" goto fail
          pos += 7
          goto R900

        R900: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R690: # concat
        R901: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "tailrec" goto fail
          pos += 7
          goto R902

        R902: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R688: # concat
        R903: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "primrec" goto fail
          pos += 7
          goto R904

        R904: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R686: # concat
        R905: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "treerec" goto fail
          pos += 7
          goto R906

        R906: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R684: # concat
        R907: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "setecho" goto fail
          pos += 7
          goto R908

        R908: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R682: # concat
        R909: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "include" goto fail
          pos += 7
          goto R910

        R910: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R680: # concat
        R911: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "reverse" goto fail
          pos += 7
          goto R912

        R912: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R678: # concat
        R913: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "maxint" goto fail
          pos += 6
          goto R914

        R914: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R676: # concat
        R915: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "undefs" goto fail
          pos += 6
          goto R916

        R916: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R674: # concat
        R917: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "stdout" goto fail
          pos += 6
          goto R918

        R918: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R672: # concat
        R919: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "stderr" goto fail
          pos += 6
          goto R920

        R920: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R670: # concat
        R921: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "rollup" goto fail
          pos += 6
          goto R922

        R922: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R668: # concat
        R923: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "rotate" goto fail
          pos += 6
          goto R924

        R924: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R666: # concat
        R925: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "choice" goto fail
          pos += 6
          goto R926

        R926: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R664: # concat
        R927: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "gmtime" goto fail
          pos += 6
          goto R928

        R928: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R662: # concat
        R929: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "mktime" goto fail
          pos += 6
          goto R930

        R930: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R660: # concat
        R931: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "strtol" goto fail
          pos += 6
          goto R932

        R932: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R658: # concat
        R933: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "strtod" goto fail
          pos += 6
          goto R934

        R934: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R656: # concat
        R935: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "format" goto fail
          pos += 6
          goto R936

        R936: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R654: # concat
        R937: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fclose" goto fail
          pos += 6
          goto R938

        R938: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R652: # concat
        R939: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "ferror" goto fail
          pos += 6
          goto R940

        R940: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R650: # concat
        R941: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fflush" goto fail
          pos += 6
          goto R942

        R942: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R648: # concat
        R943: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fgetch" goto fail
          pos += 6
          goto R944

        R944: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R646: # concat
        R945: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fwrite" goto fail
          pos += 6
          goto R946

        R946: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R644: # concat
        R947: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fputch" goto fail
          pos += 6
          goto R948

        R948: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R642: # concat
        R949: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "opcase" goto fail
          pos += 6
          goto R950

        R950: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R640: # concat
        R951: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "uncons" goto fail
          pos += 6
          goto R952

        R952: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R638: # concat
        R953: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "concat" goto fail
          pos += 6
          goto R954

        R954: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R636: # concat
        R955: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "intern" goto fail
          pos += 6
          goto R956

        R956: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R634: # concat
        R957: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "string" goto fail
          pos += 6
          goto R958

        R958: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R632: # concat
        R959: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "unary2" goto fail
          pos += 6
          goto R960

        R960: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R630: # concat
        R961: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "unary3" goto fail
          pos += 6
          goto R962

        R962: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R628: # concat
        R963: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "unary4" goto fail
          pos += 6
          goto R964

        R964: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R626: # concat
        R965: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "binary" goto fail
          pos += 6
          goto R966

        R966: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R624: # concat
        R967: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "cleave" goto fail
          pos += 6
          goto R968

        R968: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R622: # concat
        R969: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "branch" goto fail
          pos += 6
          goto R970

        R970: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R620: # concat
        R971: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "ifchar" goto fail
          pos += 6
          goto R972

        R972: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R618: # concat
        R973: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "iflist" goto fail
          pos += 6
          goto R974

        R974: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R616: # concat
        R975: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "iffile" goto fail
          pos += 6
          goto R976

        R976: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R614: # concat
        R977: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "linrec" goto fail
          pos += 6
          goto R978

        R978: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R612: # concat
        R979: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "binrec" goto fail
          pos += 6
          goto R980

        R980: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R610: # concat
        R981: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "genrec" goto fail
          pos += 6
          goto R982

        R982: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R608: # concat
        R983: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "filter" goto fail
          pos += 6
          goto R984

        R984: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R606: # concat
        R985: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "manual" goto fail
          pos += 6
          goto R986

        R986: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R604: # concat
        R987: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "system" goto fail
          pos += 6
          goto R988

        R988: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R602: # concat
        R989: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "getenv" goto fail
          pos += 6
          goto R990

        R990: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R600: # concat
        R991: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "print" goto fail
          pos += 5
          goto R992

        R992: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R598: # concat
        R993: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "stack" goto fail
          pos += 5
          goto R994

        R994: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R596: # concat
        R995: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "conts" goto fail
          pos += 5
          goto R996

        R996: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R594: # concat
        R997: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "clock" goto fail
          pos += 5
          goto R998

        R998: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R592: # concat
        R999: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "stdin" goto fail
          pos += 5
          goto R1000

        R1000: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R590: # concat
        R1001: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "swapd" goto fail
          pos += 5
          goto R1002

        R1002: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R588: # concat
        R1003: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "atan2" goto fail
          pos += 5
          goto R1004

        R1004: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R586: # concat
        R1005: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "floor" goto fail
          pos += 5
          goto R1006

        R1006: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R584: # concat
        R1007: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "frexp" goto fail
          pos += 5
          goto R1008

        R1008: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R582: # concat
        R1009: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "ldexp" goto fail
          pos += 5
          goto R1010

        R1010: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R580: # concat
        R1011: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "log10" goto fail
          pos += 5
          goto R1012

        R1012: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R578: # concat
        R1013: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "trunc" goto fail
          pos += 5
          goto R1014

        R1014: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R576: # concat
        R1015: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "srand" goto fail
          pos += 5
          goto R1016

        R1016: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R574: # concat
        R1017: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fgets" goto fail
          pos += 5
          goto R1018

        R1018: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R572: # concat
        R1019: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fopen" goto fail
          pos += 5
          goto R1020

        R1020: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R570: # concat
        R1021: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fread" goto fail
          pos += 5
          goto R1022

        R1022: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R568: # concat
        R1023: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fseek" goto fail
          pos += 5
          goto R1024

        R1024: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R566: # concat
        R1025: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "ftell" goto fail
          pos += 5
          goto R1026

        R1026: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R564: # concat
        R1027: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "swons" goto fail
          pos += 5
          goto R1028

        R1028: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R562: # concat
        R1029: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "first" goto fail
          pos += 5
          goto R1030

        R1030: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R560: # concat
        R1031: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "small" goto fail
          pos += 5
          goto R1032

        R1032: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R558: # concat
        R1033: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "equal" goto fail
          pos += 5
          goto R1034

        R1034: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R556: # concat
        R1035: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "float" goto fail
          pos += 5
          goto R1036

        R1036: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R554: # concat
        R1037: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "app11" goto fail
          pos += 5
          goto R1038

        R1038: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R552: # concat
        R1039: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "app12" goto fail
          pos += 5
          goto R1040

        R1040: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R550: # concat
        R1041: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "unary" goto fail
          pos += 5
          goto R1042

        R1042: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R548: # concat
        R1043: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "ifset" goto fail
          pos += 5
          goto R1044

        R1044: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R546: # concat
        R1045: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "while" goto fail
          pos += 5
          goto R1046

        R1046: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R544: # concat
        R1047: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "times" goto fail
          pos += 5
          goto R1048

        R1048: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R542: # concat
        R1049: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "infra" goto fail
          pos += 5
          goto R1050

        R1050: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R540: # concat
        R1051: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "split" goto fail
          pos += 5
          goto R1052

        R1052: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R538: # concat
        R1053: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "putch" goto fail
          pos += 5
          goto R1054

        R1054: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R536: # concat
        R1055: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "abort" goto fail
          pos += 5
          goto R1056

        R1056: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R534: # concat
        R1057: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "echo" goto fail
          pos += 4
          goto R1058

        R1058: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R532: # concat
        R1059: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "time" goto fail
          pos += 4
          goto R1060

        R1060: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R530: # concat
        R1061: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "rand" goto fail
          pos += 4
          goto R1062

        R1062: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R528: # concat
        R1063: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "swap" goto fail
          pos += 4
          goto R1064

        R1064: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R526: # concat
        R1065: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "popd" goto fail
          pos += 4
          goto R1066

        R1066: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R524: # concat
        R1067: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "dupd" goto fail
          pos += 4
          goto R1068

        R1068: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R522: # concat
        R1069: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "sign" goto fail
          pos += 4
          goto R1070

        R1070: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R520: # concat
        R1071: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "acos" goto fail
          pos += 4
          goto R1072

        R1072: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R518: # concat
        R1073: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "asin" goto fail
          pos += 4
          goto R1074

        R1074: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R516: # concat
        R1075: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "atan" goto fail
          pos += 4
          goto R1076

        R1076: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R514: # concat
        R1077: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "ceil" goto fail
          pos += 4
          goto R1078

        R1078: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R512: # concat
        R1079: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "cosh" goto fail
          pos += 4
          goto R1080

        R1080: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R510: # concat
        R1081: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "modf" goto fail
          pos += 4
          goto R1082

        R1082: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R508: # concat
        R1083: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "sinh" goto fail
          pos += 4
          goto R1084

        R1084: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R506: # concat
        R1085: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "sqrt" goto fail
          pos += 4
          goto R1086

        R1086: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R504: # concat
        R1087: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "tanh" goto fail
          pos += 4
          goto R1088

        R1088: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R502: # concat
        R1089: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "pred" goto fail
          pos += 4
          goto R1090

        R1090: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R500: # concat
        R1091: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "succ" goto fail
          pos += 4
          goto R1092

        R1092: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R498: # concat
        R1093: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "feof" goto fail
          pos += 4
          goto R1094

        R1094: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R496: # concat
        R1095: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "fput" goto fail
          pos += 4
          goto R1096

        R1096: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R494: # concat
        R1097: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "cons" goto fail
          pos += 4
          goto R1098

        R1098: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R492: # concat
        R1099: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "rest" goto fail
          pos += 4
          goto R1100

        R1100: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R490: # concat
        R1101: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "size" goto fail
          pos += 4
          goto R1102

        R1102: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R488: # concat
        R1103: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "case" goto fail
          pos += 4
          goto R1104

        R1104: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R486: # concat
        R1105: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "drop" goto fail
          pos += 4
          goto R1106

        R1106: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R484: # concat
        R1107: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "take" goto fail
          pos += 4
          goto R1108

        R1108: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R482: # concat
        R1109: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "name" goto fail
          pos += 4
          goto R1110

        R1110: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R480: # concat
        R1111: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "body" goto fail
          pos += 4
          goto R1112

        R1112: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R478: # concat
        R1113: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "null" goto fail
          pos += 4
          goto R1114

        R1114: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R476: # concat
        R1115: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "char" goto fail
          pos += 4
          goto R1116

        R1116: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R474: # concat
        R1117: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "list" goto fail
          pos += 4
          goto R1118

        R1118: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R472: # concat
        R1119: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "leaf" goto fail
          pos += 4
          goto R1120

        R1120: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R470: # concat
        R1121: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "user" goto fail
          pos += 4
          goto R1122

        R1122: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R468: # concat
        R1123: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "file" goto fail
          pos += 4
          goto R1124

        R1124: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R466: # concat
        R1125: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "app1" goto fail
          pos += 4
          goto R1126

        R1126: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R464: # concat
        R1127: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "ifte" goto fail
          pos += 4
          goto R1128

        R1128: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R462: # concat
        R1129: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "cond" goto fail
          pos += 4
          goto R1130

        R1130: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R460: # concat
        R1131: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "step" goto fail
          pos += 4
          goto R1132

        R1132: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R458: # concat
        R1133: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "fold" goto fail
          pos += 4
          goto R1134

        R1134: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R456: # concat
        R1135: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "some" goto fail
          pos += 4
          goto R1136

        R1136: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R454: # concat
        R1137: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "help" goto fail
          pos += 4
          goto R1138

        R1138: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R452: # concat
        R1139: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "argv" goto fail
          pos += 4
          goto R1140

        R1140: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R450: # concat
        R1141: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "argc" goto fail
          pos += 4
          goto R1142

        R1142: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R448: # concat
        R1143: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "quit" goto fail
          pos += 4
          goto R1144

        R1144: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R446: # concat
        R1145: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "dup" goto fail
          pos += 3
          goto R1146

        R1146: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R444: # concat
        R1147: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "pop" goto fail
          pos += 3
          goto R1148

        R1148: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R442: # concat
        R1149: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "not" goto fail
          pos += 3
          goto R1150

        R1150: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R440: # concat
        R1151: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "neg" goto fail
          pos += 3
          goto R1152

        R1152: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R438: # concat
        R1153: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "ord" goto fail
          pos += 3
          goto R1154

        R1154: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R436: # concat
        R1155: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "chr" goto fail
          pos += 3
          goto R1156

        R1156: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R434: # concat
        R1157: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "abs" goto fail
          pos += 3
          goto R1158

        R1158: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R432: # concat
        R1159: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "cos" goto fail
          pos += 3
          goto R1160

        R1160: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R430: # concat
        R1161: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "exp" goto fail
          pos += 3
          goto R1162

        R1162: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R428: # concat
        R1163: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "log" goto fail
          pos += 3
          goto R1164

        R1164: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R426: # concat
        R1165: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "pow" goto fail
          pos += 3
          goto R1166

        R1166: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R424: # concat
        R1167: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "sin" goto fail
          pos += 3
          goto R1168

        R1168: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R422: # concat
        R1169: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "tan" goto fail
          pos += 3
          goto R1170

        R1170: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R420: # concat
        R1171: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "max" goto fail
          pos += 3
          goto R1172

        R1172: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R418: # concat
        R1173: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "min" goto fail
          pos += 3
          goto R1174

        R1174: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R416: # concat
        R1175: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "has" goto fail
          pos += 3
          goto R1176

        R1176: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R414: # concat
        R1177: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "set" goto fail
          pos += 3
          goto R1178

        R1178: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R412: # concat
        R1179: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "dip" goto fail
          pos += 3
          goto R1180

        R1180: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R410: # concat
        R1181: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "map" goto fail
          pos += 3
          goto R1182

        R1182: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R408: # concat
        R1183: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "all" goto fail
          pos += 3
          goto R1184

        R1184: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R406: # concat
        R1185: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "get" goto fail
          pos += 3
          goto R1186

        R1186: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R404: # concat
        R1187: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "put" goto fail
          pos += 3
          goto R1188

        R1188: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R402: # concat
        R1189: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "id" goto fail
          pos += 2
          goto R1190

        R1190: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R400: # concat
        R1191: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "at" goto fail
          pos += 2
          goto R1192

        R1192: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R398: # concat
        R1193: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "of" goto fail
          pos += 2
          goto R1194

        R1194: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R396: # concat
        R1195: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "in" goto fail
          pos += 2
          goto R1196

        R1196: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R394: # concat
        R1197: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "i" goto fail
          pos += 1
          goto R1198

        R1198: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
        R392: # concat
        R1199: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "x" goto fail
          pos += 1
          goto R1200

        R1200: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."builtins"(mob)
          goto succeed
      .end

## <fun::Grammar::userfunccall>
.namespace ["fun";"Grammar"]
      .sub "userfunccall" :method
          .param pmc adverbs      :unique_reg :slurpy :named
          .local pmc mob
          .local string target    :unique_reg
          .local pmc mfrom, mpos  :unique_reg
          .local int cpos, iscont :unique_reg
          $P0 = get_hll_global ['PGE'], 'Match'
          (mob, cpos, target, mfrom, mpos, iscont) = $P0.'new'(self, adverbs :flat :named)
          .local int lastpos
          lastpos = length target
          if cpos > lastpos goto fail_rule
          .local pmc cstack :unique_reg
          cstack = new 'ResizableIntegerArray'
          .local pmc captscope, captob :unique_reg
          captscope = mob
          .local int pos, rep, cutmark :unique_reg
        try_match:
          if cpos > lastpos goto fail_rule
          mfrom = cpos
          pos = cpos
          cutmark = 0
          local_branch cstack, R
          if cutmark <= -2 goto fail_cut
          inc cpos
          if iscont goto try_match
        fail_rule:
          cutmark = -2
        fail_cut:
          mob.'_failcut'(cutmark)
          .return (mob)
          goto fail_cut
        succeed:
          mpos = pos
          .return (mob)
        fail:
          local_return cstack
        fail_match:
          cutmark = -3
          goto fail_cut
        R: # concat
        R1201: # subrule funcname
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'funcname'
          if $I0 == 0 goto R1201_1
          $P0 = find_method mob, 'funcname'
          goto R1201_2
        R1201_1:
          $P0 = find_name 'funcname'
          unless null $P0 goto R1201_2
          say "Unable to find regex 'funcname'"
        R1201_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["funcname"] = captob

          pos = $P1
          local_branch cstack, R1202
          delete captscope["funcname"]

          goto fail
        R1202: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "userfunccall"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."userfunccall"(mob)
          goto succeed
      .end
