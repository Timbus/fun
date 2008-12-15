      .sub '__onload' :load :init
          .local pmc optable
          ## namespace fun::Grammar
          push_eh onload_1232
          .local pmc p6meta
          p6meta = get_hll_global 'P6metaclass'
          p6meta.'new_class'('fun::Grammar', 'parent'=>'PCT::Grammar')
        onload_1232:
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

        R277: # concat
        R282: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "=" goto fail
          pos += 1
          goto R283

        R283: # subrule before
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'before'
          if $I0 == 0 goto R283_1
          $P0 = find_method mob, 'before'
          goto R283_2
        R283_1:
          $P0 = find_name 'before'
          unless null $P0 goto R283_2
          say "Unable to find regex 'before'"
        R283_2:
          captob = $P0(captob, "'='")
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          unless $P1 < 0 goto fail
          $P1 = pos
          $P1 = getattribute captob, '$.from'
          $P1 = pos
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
        R284: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "." goto fail
          pos += 1
          goto R285

        R285: # action
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
        R:  # alt R286, R287
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

        R290:  # alt R292, R293
          push ustack, pos
          local_branch cstack, R292
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R293

        R292: # concat
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
        R295: # subrule list
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'list'
          if $I0 == 0 goto R295_1
          $P0 = find_method mob, 'list'
          goto R295_2
        R295_1:
          $P0 = find_name 'list'
          unless null $P0 goto R295_2
          say "Unable to find regex 'list'"
        R295_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["list"] = captob

          pos = $P1
          local_branch cstack, R296
          delete captscope["list"]

          goto fail
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
          local_branch cstack, R297
          
          goto fail
        R297: # action
          $P1 = adverbs['action']
          if null $P1 goto R298
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R298
          mpos = pos
          $P1."expr"(mob, "list")
          goto R298
        R298: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R298_1
          $P0 = find_method mob, 'ws'
          goto R298_2
        R298_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R298_2
          say "Unable to find regex 'ws'"
        R298_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R293: # concat
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
        R300: # subrule value
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'value'
          if $I0 == 0 goto R300_1
          $P0 = find_method mob, 'value'
          goto R300_2
        R300_1:
          $P0 = find_name 'value'
          unless null $P0 goto R300_2
          say "Unable to find regex 'value'"
        R300_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["value"] = captob

          pos = $P1
          local_branch cstack, R301
          delete captscope["value"]

          goto fail
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
          local_branch cstack, R302
          
          goto fail
        R302: # action
          $P1 = adverbs['action']
          if null $P1 goto R303
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R303
          mpos = pos
          $P1."expr"(mob, "value")
          goto R303
        R303: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R303_1
          $P0 = find_method mob, 'ws'
          goto R303_2
        R303_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R303_2
          say "Unable to find regex 'ws'"
        R303_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R291: # concat
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
        R305: # subrule print
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'print'
          if $I0 == 0 goto R305_1
          $P0 = find_method mob, 'print'
          goto R305_2
        R305_1:
          $P0 = find_name 'print'
          unless null $P0 goto R305_2
          say "Unable to find regex 'print'"
        R305_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["print"] = captob

          pos = $P1
          local_branch cstack, R306
          delete captscope["print"]

          goto fail
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
          local_branch cstack, R307
          
          goto fail
        R307: # action
          $P1 = adverbs['action']
          if null $P1 goto R308
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R308
          mpos = pos
          $P1."expr"(mob, "print")
          goto R308
        R308: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R308_1
          $P0 = find_method mob, 'ws'
          goto R308_2
        R308_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R308_2
          say "Unable to find regex 'ws'"
        R308_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R289: # concat
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
        R310: # subrule builtins
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'builtins'
          if $I0 == 0 goto R310_1
          $P0 = find_method mob, 'builtins'
          goto R310_2
        R310_1:
          $P0 = find_name 'builtins'
          unless null $P0 goto R310_2
          say "Unable to find regex 'builtins'"
        R310_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["builtins"] = captob

          pos = $P1
          local_branch cstack, R311
          delete captscope["builtins"]

          goto fail
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
          local_branch cstack, R312
          
          goto fail
        R312: # action
          $P1 = adverbs['action']
          if null $P1 goto R313
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R313
          mpos = pos
          $P1."expr"(mob, "builtins")
          goto R313
        R313: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R313_1
          $P0 = find_method mob, 'ws'
          goto R313_2
        R313_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R313_2
          say "Unable to find regex 'ws'"
        R313_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R287: # concat
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
        R315: # subrule userfunccall
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'userfunccall'
          if $I0 == 0 goto R315_1
          $P0 = find_method mob, 'userfunccall'
          goto R315_2
        R315_1:
          $P0 = find_name 'userfunccall'
          unless null $P0 goto R315_2
          say "Unable to find regex 'userfunccall'"
        R315_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["userfunccall"] = captob

          pos = $P1
          local_branch cstack, R316
          delete captscope["userfunccall"]

          goto fail
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
          local_branch cstack, R317
          
          goto fail
        R317: # action
          $P1 = adverbs['action']
          if null $P1 goto R318
          $I1 = can $P1, "expr"
          if $I1 == 0 goto R318
          mpos = pos
          $P1."expr"(mob, "userfunccall")
          goto R318
        R318: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R318_1
          $P0 = find_method mob, 'ws'
          goto R318_2
        R318_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R318_2
          say "Unable to find regex 'ws'"
        R318_2:
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
        R:  # alt R319, R320
          push ustack, pos
          local_branch cstack, R319
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R320

        R319: # concat
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
        R330: # subrule funcname
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'funcname'
          if $I0 == 0 goto R330_1
          $P0 = find_method mob, 'funcname'
          goto R330_2
        R330_1:
          $P0 = find_name 'funcname'
          unless null $P0 goto R330_2
          say "Unable to find regex 'funcname'"
        R330_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["funcname"] = captob

          pos = $P1
          local_branch cstack, R331
          delete captscope["funcname"]

          goto fail
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
          local_branch cstack, R332
          
          goto fail
        R332: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "==" goto fail
          pos += 2
          goto R333

        R333: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R333_1
          $P0 = find_method mob, 'ws'
          goto R333_2
        R333_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R333_2
          say "Unable to find regex 'ws'"
        R333_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R334
          
          goto fail
        R334: # action
          $P1 = adverbs['action']
          if null $P1 goto R335
          $I1 = can $P1, "func"
          if $I1 == 0 goto R335
          mpos = pos
          $P1."func"(mob)
          goto R335
        R335: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R335_1
          $P0 = find_method mob, 'ws'
          goto R335_2
        R335_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R335_2
          say "Unable to find regex 'ws'"
        R335_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, succeed
          
          goto fail
        R320: # concat
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
          local_branch cstack, R337
          
          goto fail
        R337: # subrule funcname
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'funcname'
          if $I0 == 0 goto R337_1
          $P0 = find_method mob, 'funcname'
          goto R337_2
        R337_1:
          $P0 = find_name 'funcname'
          unless null $P0 goto R337_2
          say "Unable to find regex 'funcname'"
        R337_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["funcname"] = captob

          pos = $P1
          local_branch cstack, R338
          delete captscope["funcname"]

          goto fail
        R338: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R338_1
          $P0 = find_method mob, 'ws'
          goto R338_2
        R338_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R338_2
          say "Unable to find regex 'ws'"
        R338_2:
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
          
          if $S0 != "[" goto fail
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
        R341:  # quant 0..Inf none
          local_branch cstack, R341_repeat
          if cutmark != 344 goto fail
          cutmark = 0
          goto fail
        R341_repeat:
          push ustack, pos
          local_branch cstack, R343
          pos = pop ustack
          if cutmark != 0 goto fail
          local_branch cstack, R342
          if cutmark != 0 goto fail
          cutmark = 344
          goto fail
        R343: # subrule expr
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'expr'
          if $I0 == 0 goto R343_1
          $P0 = find_method mob, 'expr'
          goto R343_2
        R343_1:
          $P0 = find_name 'expr'
          unless null $P0 goto R343_2
          say "Unable to find regex 'expr'"
        R343_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
                    $I0 = defined captscope["expr"]
          if $I0 goto R343_cgen
          $P0 = new 'ResizablePMCArray'
          captscope["expr"] = $P0
          local_branch cstack, R343_cgen
          delete captscope["expr"]
          goto fail
        R343_cgen:

          $P2 = captscope["expr"]
          push $P2, captob

          pos = $P1
          local_branch cstack, R343_3
          $P2 = captscope["expr"]
          $P2 = pop $P2

          goto fail
        R343_3:
          pos = $P1
          $P1 = getattribute captob, '&!corou'
          if null $P1 goto R341_repeat
          push ustack, captob
          local_branch cstack, R341_repeat
          captob = pop ustack
          if cutmark != 0 goto fail
          captob.'next'()
          $P1 = getattribute captob, '$.pos'
          if $P1 >= 0 goto R343_3
          if $P1 <= -3 goto fail_match
          goto fail

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
          local_branch cstack, R345
          
          goto fail
        R345: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "]" goto fail
          pos += 1
          goto R346

        R346: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R346_1
          $P0 = find_method mob, 'ws'
          goto R346_2
        R346_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R346_2
          say "Unable to find regex 'ws'"
        R346_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R347
          
          goto fail
        R347: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "==" goto fail
          pos += 2
          goto R348

        R348: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R348_1
          $P0 = find_method mob, 'ws'
          goto R348_2
        R348_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R348_2
          say "Unable to find regex 'ws'"
        R348_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R349
          
          goto fail
        R349: # action
          $P1 = adverbs['action']
          if null $P1 goto R350
          $I1 = can $P1, "func"
          if $I1 == 0 goto R350
          mpos = pos
          $P1."func"(mob)
          goto R350
        R350: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R350_1
          $P0 = find_method mob, 'ws'
          goto R350_2
        R350_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R350_2
          say "Unable to find regex 'ws'"
        R350_2:
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
        R351: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R351_1
          $P0 = find_method mob, 'ws'
          goto R351_2
        R351_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R351_2
          say "Unable to find regex 'ws'"
        R351_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R352
          
          goto fail
        R352: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "[" goto fail
          pos += 1
          goto R353

        R353: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R353_1
          $P0 = find_method mob, 'ws'
          goto R353_2
        R353_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R353_2
          say "Unable to find regex 'ws'"
        R353_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R354
          
          goto fail
        R354:  # quant 0..Inf none
          local_branch cstack, R354_repeat
          if cutmark != 357 goto fail
          cutmark = 0
          goto fail
        R354_repeat:
          push ustack, pos
          local_branch cstack, R356
          pos = pop ustack
          if cutmark != 0 goto fail
          local_branch cstack, R355
          if cutmark != 0 goto fail
          cutmark = 357
          goto fail
        R356: # subrule expr
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'expr'
          if $I0 == 0 goto R356_1
          $P0 = find_method mob, 'expr'
          goto R356_2
        R356_1:
          $P0 = find_name 'expr'
          unless null $P0 goto R356_2
          say "Unable to find regex 'expr'"
        R356_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
                    $I0 = defined captscope["expr"]
          if $I0 goto R356_cgen
          $P0 = new 'ResizablePMCArray'
          captscope["expr"] = $P0
          local_branch cstack, R356_cgen
          delete captscope["expr"]
          goto fail
        R356_cgen:

          $P2 = captscope["expr"]
          push $P2, captob

          pos = $P1
          local_branch cstack, R356_3
          $P2 = captscope["expr"]
          $P2 = pop $P2

          goto fail
        R356_3:
          pos = $P1
          $P1 = getattribute captob, '&!corou'
          if null $P1 goto R354_repeat
          push ustack, captob
          local_branch cstack, R354_repeat
          captob = pop ustack
          if cutmark != 0 goto fail
          captob.'next'()
          $P1 = getattribute captob, '$.pos'
          if $P1 >= 0 goto R356_3
          if $P1 <= -3 goto fail_match
          goto fail

        R355: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R355_1
          $P0 = find_method mob, 'ws'
          goto R355_2
        R355_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R355_2
          say "Unable to find regex 'ws'"
        R355_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R358
          
          goto fail
        R358: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "]" goto fail
          pos += 1
          goto R359

        R359: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R359_1
          $P0 = find_method mob, 'ws'
          goto R359_2
        R359_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R359_2
          say "Unable to find regex 'ws'"
        R359_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          
          pos = $P1
          local_branch cstack, R360
          
          goto fail
        R360: # action
          $P1 = adverbs['action']
          if null $P1 goto R361
          $I1 = can $P1, "list"
          if $I1 == 0 goto R361
          mpos = pos
          $P1."list"(mob)
          goto R361
        R361: # subrule ws
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'ws'
          if $I0 == 0 goto R361_1
          $P0 = find_method mob, 'ws'
          goto R361_2
        R361_1:
          $P0 = find_name 'ws'
          unless null $P0 goto R361_2
          say "Unable to find regex 'ws'"
        R361_2:
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
        R:  # alt R362, R363
          push ustack, pos
          local_branch cstack, R362
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R363

        R362:  # alt R364, R365
          push ustack, pos
          local_branch cstack, R364
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R365

        R364:  # alt R366, R367
          push ustack, pos
          local_branch cstack, R366
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R367

        R366: # concat
        R368: # subrule float
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'float'
          if $I0 == 0 goto R368_1
          $P0 = find_method mob, 'float'
          goto R368_2
        R368_1:
          $P0 = find_name 'float'
          unless null $P0 goto R368_2
          say "Unable to find regex 'float'"
        R368_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["float"] = captob

          pos = $P1
          local_branch cstack, R369
          delete captscope["float"]

          goto fail
        R369: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "value"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."value"(mob, "float")
          goto succeed
        R367: # concat
        R370: # subrule integer
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'integer'
          if $I0 == 0 goto R370_1
          $P0 = find_method mob, 'integer'
          goto R370_2
        R370_1:
          $P0 = find_name 'integer'
          unless null $P0 goto R370_2
          say "Unable to find regex 'integer'"
        R370_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["integer"] = captob

          pos = $P1
          local_branch cstack, R371
          delete captscope["integer"]

          goto fail
        R371: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "value"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."value"(mob, "integer")
          goto succeed
        R365: # concat
        R372: # subrule string
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'string'
          if $I0 == 0 goto R372_1
          $P0 = find_method mob, 'string'
          goto R372_2
        R372_1:
          $P0 = find_name 'string'
          unless null $P0 goto R372_2
          say "Unable to find regex 'string'"
        R372_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["string"] = captob

          pos = $P1
          local_branch cstack, R373
          delete captscope["string"]

          goto fail
        R373: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "value"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."value"(mob, "string")
          goto succeed
        R363: # concat
        R374: # subrule bool
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'bool'
          if $I0 == 0 goto R374_1
          $P0 = find_method mob, 'bool'
          goto R374_2
        R374_1:
          $P0 = find_name 'bool'
          unless null $P0 goto R374_2
          say "Unable to find regex 'bool'"
        R374_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["bool"] = captob

          pos = $P1
          local_branch cstack, R375
          delete captscope["bool"]

          goto fail
        R375: # action
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
        R376:  # quant 0..1 (3) greedy/none
          push gpad, 0
          local_branch cstack, R376_repeat
          $I0 = pop gpad
          if cutmark != 379 goto fail
          cutmark = 0
          goto fail
        R376_repeat:
          rep = gpad[-1]
          if rep >= 1 goto R376_1
          inc rep
          gpad[-1] = rep
          push ustack, pos
          push ustack, rep
          local_branch cstack, R378
          rep = pop ustack
          pos = pop ustack
          if cutmark != 0 goto fail
          dec rep
        R376_1:
          ### if rep < 0 goto fail
          $I0 = pop gpad
          push ustack, rep
          local_branch cstack, R377
          rep = pop ustack
          push gpad, rep
          if cutmark != 0 goto fail
          cutmark = 379
          goto fail

        R378: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "-" goto fail
          pos += 1
          goto R376_repeat

        R377: # cclass \d 1..2147483647 (3)
          $I0 = find_not_cclass 8, target, pos, lastpos
          rep = $I0 - pos
          if rep < 1 goto fail
          ### if rep <= 2147483647 goto R377_1
          ### rep = 2147483647
        R377_1:
          pos += rep
          goto R380
        R380: # action
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
        R381:  # quant 0..1 (3) greedy/none
          push gpad, 0
          local_branch cstack, R381_repeat
          $I0 = pop gpad
          if cutmark != 384 goto fail
          cutmark = 0
          goto fail
        R381_repeat:
          rep = gpad[-1]
          if rep >= 1 goto R381_1
          inc rep
          gpad[-1] = rep
          push ustack, pos
          push ustack, rep
          local_branch cstack, R383
          rep = pop ustack
          pos = pop ustack
          if cutmark != 0 goto fail
          dec rep
        R381_1:
          ### if rep < 0 goto fail
          $I0 = pop gpad
          push ustack, rep
          local_branch cstack, R382
          rep = pop ustack
          push gpad, rep
          if cutmark != 0 goto fail
          cutmark = 384
          goto fail

        R383: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "-" goto fail
          pos += 1
          goto R381_repeat

        R382: # cclass \d 1..2147483647 (3)
          $I0 = find_not_cclass 8, target, pos, lastpos
          rep = $I0 - pos
          if rep < 1 goto fail
          ### if rep <= 2147483647 goto R382_1
          ### rep = 2147483647
        R382_1:
          pos += rep
          goto R385
        R385: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "." goto fail
          pos += 1
          goto R386

        R386: # cclass \d 1..2147483647 (3)
          $I0 = find_not_cclass 8, target, pos, lastpos
          rep = $I0 - pos
          if rep < 1 goto fail
          ### if rep <= 2147483647 goto R386_1
          ### rep = 2147483647
        R386_1:
          pos += rep
          goto R387
        R387: # action
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
        R389:  # group 388
          local_branch cstack, R391
          if cutmark != 388 goto fail
          cutmark = 0
          goto fail

        R391: # concat
        R392:  # alt R394, R395
          push ustack, pos
          local_branch cstack, R394
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R395

        R394: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "true" goto fail
          pos += 4
          goto R393

        R395: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "false" goto fail
          pos += 5
          goto R393

        R393: # cut 388
          local_branch cstack, R390
          cutmark = 388
          goto fail

        R390: # action
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
        R397:  # group 396
          local_branch cstack, R399
          if cutmark != 396 goto fail
          cutmark = 0
          goto fail

        R399: # concat
        R400:  # alt R402, R403
          push ustack, pos
          local_branch cstack, R402
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R403

        R402: # concat
        R404: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "'" goto fail
          pos += 1
          goto R405

        R405: # subrule string_literal
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'string_literal'
          if $I0 == 0 goto R405_1
          $P0 = find_method mob, 'string_literal'
          goto R405_2
        R405_1:
          $P0 = find_name 'string_literal'
          unless null $P0 goto R405_2
          say "Unable to find regex 'string_literal'"
        R405_2:
          $P2 = adverbs['action']
          captob = $P0(captob, "'", 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["string_literal"] = captob

          pos = $P1
          local_branch cstack, R406
          delete captscope["string_literal"]

          goto fail
        R406: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "'" goto fail
          pos += 1
          goto R401

        R403: # concat
        R407: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "\"" goto fail
          pos += 1
          goto R408

        R408: # subrule string_literal
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'string_literal'
          if $I0 == 0 goto R408_1
          $P0 = find_method mob, 'string_literal'
          goto R408_2
        R408_1:
          $P0 = find_name 'string_literal'
          unless null $P0 goto R408_2
          say "Unable to find regex 'string_literal'"
        R408_2:
          $P2 = adverbs['action']
          captob = $P0(captob, "\"", 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["string_literal"] = captob

          pos = $P1
          local_branch cstack, R409
          delete captscope["string_literal"]

          goto fail
        R409: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "\"" goto fail
          pos += 1
          goto R401

        R401: # cut 396
          local_branch cstack, R398
          cutmark = 396
          goto fail

        R398: # action
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
        R411:  # group 410
          local_branch cstack, R413
          if cutmark != 410 goto fail
          cutmark = 0
          goto fail

        R413: # concat
        R414:  # alt R416, R417
          push ustack, pos
          local_branch cstack, R416
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R417

        R416:  # alt R418, R419
          push ustack, pos
          local_branch cstack, R418
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R419

        R418:  # alt R420, R421
          push ustack, pos
          local_branch cstack, R420
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R421

        R420:  # alt R422, R423
          push ustack, pos
          local_branch cstack, R422
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R423

        R422:  # alt R424, R425
          push ustack, pos
          local_branch cstack, R424
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R425

        R424:  # alt R426, R427
          push ustack, pos
          local_branch cstack, R426
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R427

        R426:  # alt R428, R429
          push ustack, pos
          local_branch cstack, R428
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R429

        R428:  # alt R430, R431
          push ustack, pos
          local_branch cstack, R430
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R431

        R430:  # alt R432, R433
          push ustack, pos
          local_branch cstack, R432
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R433

        R432:  # alt R434, R435
          push ustack, pos
          local_branch cstack, R434
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R435

        R434:  # alt R436, R437
          push ustack, pos
          local_branch cstack, R436
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R437

        R436:  # alt R438, R439
          push ustack, pos
          local_branch cstack, R438
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R439

        R438:  # alt R440, R441
          push ustack, pos
          local_branch cstack, R440
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R441

        R440:  # alt R442, R443
          push ustack, pos
          local_branch cstack, R442
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R443

        R442:  # alt R444, R445
          push ustack, pos
          local_branch cstack, R444
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R445

        R444:  # alt R446, R447
          push ustack, pos
          local_branch cstack, R446
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R447

        R446:  # alt R448, R449
          push ustack, pos
          local_branch cstack, R448
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R449

        R448:  # alt R450, R451
          push ustack, pos
          local_branch cstack, R450
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R451

        R450:  # alt R452, R453
          push ustack, pos
          local_branch cstack, R452
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R453

        R452:  # alt R454, R455
          push ustack, pos
          local_branch cstack, R454
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R455

        R454:  # alt R456, R457
          push ustack, pos
          local_branch cstack, R456
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R457

        R456:  # alt R458, R459
          push ustack, pos
          local_branch cstack, R458
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R459

        R458:  # alt R460, R461
          push ustack, pos
          local_branch cstack, R460
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R461

        R460:  # alt R462, R463
          push ustack, pos
          local_branch cstack, R462
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R463

        R462:  # alt R464, R465
          push ustack, pos
          local_branch cstack, R464
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R465

        R464:  # alt R466, R467
          push ustack, pos
          local_branch cstack, R466
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R467

        R466:  # alt R468, R469
          push ustack, pos
          local_branch cstack, R468
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R469

        R468:  # alt R470, R471
          push ustack, pos
          local_branch cstack, R470
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R471

        R470:  # alt R472, R473
          push ustack, pos
          local_branch cstack, R472
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R473

        R472:  # alt R474, R475
          push ustack, pos
          local_branch cstack, R474
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R475

        R474:  # alt R476, R477
          push ustack, pos
          local_branch cstack, R476
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R477

        R476:  # alt R478, R479
          push ustack, pos
          local_branch cstack, R478
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R479

        R478:  # alt R480, R481
          push ustack, pos
          local_branch cstack, R480
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R481

        R480:  # alt R482, R483
          push ustack, pos
          local_branch cstack, R482
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R483

        R482:  # alt R484, R485
          push ustack, pos
          local_branch cstack, R484
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R485

        R484:  # alt R486, R487
          push ustack, pos
          local_branch cstack, R486
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R487

        R486:  # alt R488, R489
          push ustack, pos
          local_branch cstack, R488
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R489

        R488:  # alt R490, R491
          push ustack, pos
          local_branch cstack, R490
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R491

        R490:  # alt R492, R493
          push ustack, pos
          local_branch cstack, R492
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R493

        R492:  # alt R494, R495
          push ustack, pos
          local_branch cstack, R494
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R495

        R494:  # alt R496, R497
          push ustack, pos
          local_branch cstack, R496
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R497

        R496:  # alt R498, R499
          push ustack, pos
          local_branch cstack, R498
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R499

        R498:  # alt R500, R501
          push ustack, pos
          local_branch cstack, R500
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R501

        R500:  # alt R502, R503
          push ustack, pos
          local_branch cstack, R502
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R503

        R502:  # alt R504, R505
          push ustack, pos
          local_branch cstack, R504
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R505

        R504:  # alt R506, R507
          push ustack, pos
          local_branch cstack, R506
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R507

        R506:  # alt R508, R509
          push ustack, pos
          local_branch cstack, R508
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R509

        R508:  # alt R510, R511
          push ustack, pos
          local_branch cstack, R510
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R511

        R510:  # alt R512, R513
          push ustack, pos
          local_branch cstack, R512
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R513

        R512:  # alt R514, R515
          push ustack, pos
          local_branch cstack, R514
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R515

        R514:  # alt R516, R517
          push ustack, pos
          local_branch cstack, R516
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R517

        R516:  # alt R518, R519
          push ustack, pos
          local_branch cstack, R518
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R519

        R518:  # alt R520, R521
          push ustack, pos
          local_branch cstack, R520
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R521

        R520:  # alt R522, R523
          push ustack, pos
          local_branch cstack, R522
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R523

        R522:  # alt R524, R525
          push ustack, pos
          local_branch cstack, R524
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R525

        R524:  # alt R526, R527
          push ustack, pos
          local_branch cstack, R526
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R527

        R526:  # alt R528, R529
          push ustack, pos
          local_branch cstack, R528
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R529

        R528:  # alt R530, R531
          push ustack, pos
          local_branch cstack, R530
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R531

        R530:  # alt R532, R533
          push ustack, pos
          local_branch cstack, R532
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R533

        R532:  # alt R534, R535
          push ustack, pos
          local_branch cstack, R534
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R535

        R534:  # alt R536, R537
          push ustack, pos
          local_branch cstack, R536
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R537

        R536:  # alt R538, R539
          push ustack, pos
          local_branch cstack, R538
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R539

        R538:  # alt R540, R541
          push ustack, pos
          local_branch cstack, R540
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R541

        R540:  # alt R542, R543
          push ustack, pos
          local_branch cstack, R542
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R543

        R542:  # alt R544, R545
          push ustack, pos
          local_branch cstack, R544
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R545

        R544:  # alt R546, R547
          push ustack, pos
          local_branch cstack, R546
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R547

        R546:  # alt R548, R549
          push ustack, pos
          local_branch cstack, R548
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R549

        R548:  # alt R550, R551
          push ustack, pos
          local_branch cstack, R550
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R551

        R550:  # alt R552, R553
          push ustack, pos
          local_branch cstack, R552
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R553

        R552:  # alt R554, R555
          push ustack, pos
          local_branch cstack, R554
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R555

        R554:  # alt R556, R557
          push ustack, pos
          local_branch cstack, R556
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R557

        R556:  # alt R558, R559
          push ustack, pos
          local_branch cstack, R558
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R559

        R558:  # alt R560, R561
          push ustack, pos
          local_branch cstack, R560
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R561

        R560:  # alt R562, R563
          push ustack, pos
          local_branch cstack, R562
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R563

        R562:  # alt R564, R565
          push ustack, pos
          local_branch cstack, R564
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R565

        R564:  # alt R566, R567
          push ustack, pos
          local_branch cstack, R566
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R567

        R566:  # alt R568, R569
          push ustack, pos
          local_branch cstack, R568
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R569

        R568:  # alt R570, R571
          push ustack, pos
          local_branch cstack, R570
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R571

        R570:  # alt R572, R573
          push ustack, pos
          local_branch cstack, R572
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R573

        R572:  # alt R574, R575
          push ustack, pos
          local_branch cstack, R574
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R575

        R574:  # alt R576, R577
          push ustack, pos
          local_branch cstack, R576
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R577

        R576:  # alt R578, R579
          push ustack, pos
          local_branch cstack, R578
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R579

        R578:  # alt R580, R581
          push ustack, pos
          local_branch cstack, R580
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R581

        R580:  # alt R582, R583
          push ustack, pos
          local_branch cstack, R582
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R583

        R582:  # alt R584, R585
          push ustack, pos
          local_branch cstack, R584
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R585

        R584:  # alt R586, R587
          push ustack, pos
          local_branch cstack, R586
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R587

        R586:  # alt R588, R589
          push ustack, pos
          local_branch cstack, R588
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R589

        R588:  # alt R590, R591
          push ustack, pos
          local_branch cstack, R590
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R591

        R590:  # alt R592, R593
          push ustack, pos
          local_branch cstack, R592
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R593

        R592:  # alt R594, R595
          push ustack, pos
          local_branch cstack, R594
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R595

        R594:  # alt R596, R597
          push ustack, pos
          local_branch cstack, R596
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R597

        R596:  # alt R598, R599
          push ustack, pos
          local_branch cstack, R598
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R599

        R598:  # alt R600, R601
          push ustack, pos
          local_branch cstack, R600
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R601

        R600:  # alt R602, R603
          push ustack, pos
          local_branch cstack, R602
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R603

        R602:  # alt R604, R605
          push ustack, pos
          local_branch cstack, R604
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R605

        R604:  # alt R606, R607
          push ustack, pos
          local_branch cstack, R606
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R607

        R606:  # alt R608, R609
          push ustack, pos
          local_branch cstack, R608
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R609

        R608:  # alt R610, R611
          push ustack, pos
          local_branch cstack, R610
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R611

        R610:  # alt R612, R613
          push ustack, pos
          local_branch cstack, R612
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R613

        R612:  # alt R614, R615
          push ustack, pos
          local_branch cstack, R614
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R615

        R614:  # alt R616, R617
          push ustack, pos
          local_branch cstack, R616
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R617

        R616:  # alt R618, R619
          push ustack, pos
          local_branch cstack, R618
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R619

        R618:  # alt R620, R621
          push ustack, pos
          local_branch cstack, R620
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R621

        R620:  # alt R622, R623
          push ustack, pos
          local_branch cstack, R622
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R623

        R622:  # alt R624, R625
          push ustack, pos
          local_branch cstack, R624
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R625

        R624:  # alt R626, R627
          push ustack, pos
          local_branch cstack, R626
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R627

        R626:  # alt R628, R629
          push ustack, pos
          local_branch cstack, R628
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R629

        R628:  # alt R630, R631
          push ustack, pos
          local_branch cstack, R630
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R631

        R630:  # alt R632, R633
          push ustack, pos
          local_branch cstack, R632
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R633

        R632:  # alt R634, R635
          push ustack, pos
          local_branch cstack, R634
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R635

        R634:  # alt R636, R637
          push ustack, pos
          local_branch cstack, R636
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R637

        R636:  # alt R638, R639
          push ustack, pos
          local_branch cstack, R638
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R639

        R638:  # alt R640, R641
          push ustack, pos
          local_branch cstack, R640
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R641

        R640:  # alt R642, R643
          push ustack, pos
          local_branch cstack, R642
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R643

        R642:  # alt R644, R645
          push ustack, pos
          local_branch cstack, R644
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R645

        R644:  # alt R646, R647
          push ustack, pos
          local_branch cstack, R646
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R647

        R646:  # alt R648, R649
          push ustack, pos
          local_branch cstack, R648
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R649

        R648:  # alt R650, R651
          push ustack, pos
          local_branch cstack, R650
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R651

        R650:  # alt R652, R653
          push ustack, pos
          local_branch cstack, R652
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R653

        R652:  # alt R654, R655
          push ustack, pos
          local_branch cstack, R654
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R655

        R654:  # alt R656, R657
          push ustack, pos
          local_branch cstack, R656
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R657

        R656:  # alt R658, R659
          push ustack, pos
          local_branch cstack, R658
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R659

        R658:  # alt R660, R661
          push ustack, pos
          local_branch cstack, R660
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R661

        R660:  # alt R662, R663
          push ustack, pos
          local_branch cstack, R662
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R663

        R662:  # alt R664, R665
          push ustack, pos
          local_branch cstack, R664
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R665

        R664:  # alt R666, R667
          push ustack, pos
          local_branch cstack, R666
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R667

        R666:  # alt R668, R669
          push ustack, pos
          local_branch cstack, R668
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R669

        R668:  # alt R670, R671
          push ustack, pos
          local_branch cstack, R670
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R671

        R670:  # alt R672, R673
          push ustack, pos
          local_branch cstack, R672
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R673

        R672:  # alt R674, R675
          push ustack, pos
          local_branch cstack, R674
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R675

        R674:  # alt R676, R677
          push ustack, pos
          local_branch cstack, R676
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R677

        R676:  # alt R678, R679
          push ustack, pos
          local_branch cstack, R678
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R679

        R678:  # alt R680, R681
          push ustack, pos
          local_branch cstack, R680
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R681

        R680:  # alt R682, R683
          push ustack, pos
          local_branch cstack, R682
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R683

        R682:  # alt R684, R685
          push ustack, pos
          local_branch cstack, R684
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R685

        R684:  # alt R686, R687
          push ustack, pos
          local_branch cstack, R686
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R687

        R686:  # alt R688, R689
          push ustack, pos
          local_branch cstack, R688
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R689

        R688:  # alt R690, R691
          push ustack, pos
          local_branch cstack, R690
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R691

        R690:  # alt R692, R693
          push ustack, pos
          local_branch cstack, R692
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R693

        R692:  # alt R694, R695
          push ustack, pos
          local_branch cstack, R694
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R695

        R694:  # alt R696, R697
          push ustack, pos
          local_branch cstack, R696
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R697

        R696:  # alt R698, R699
          push ustack, pos
          local_branch cstack, R698
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R699

        R698:  # alt R700, R701
          push ustack, pos
          local_branch cstack, R700
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R701

        R700:  # alt R702, R703
          push ustack, pos
          local_branch cstack, R702
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R703

        R702:  # alt R704, R705
          push ustack, pos
          local_branch cstack, R704
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R705

        R704:  # alt R706, R707
          push ustack, pos
          local_branch cstack, R706
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R707

        R706:  # alt R708, R709
          push ustack, pos
          local_branch cstack, R708
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R709

        R708:  # alt R710, R711
          push ustack, pos
          local_branch cstack, R710
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R711

        R710:  # alt R712, R713
          push ustack, pos
          local_branch cstack, R712
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R713

        R712:  # alt R714, R715
          push ustack, pos
          local_branch cstack, R714
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R715

        R714:  # alt R716, R717
          push ustack, pos
          local_branch cstack, R716
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R717

        R716:  # alt R718, R719
          push ustack, pos
          local_branch cstack, R718
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R719

        R718:  # alt R720, R721
          push ustack, pos
          local_branch cstack, R720
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R721

        R720:  # alt R722, R723
          push ustack, pos
          local_branch cstack, R722
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R723

        R722:  # alt R724, R725
          push ustack, pos
          local_branch cstack, R724
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R725

        R724:  # alt R726, R727
          push ustack, pos
          local_branch cstack, R726
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R727

        R726:  # alt R728, R729
          push ustack, pos
          local_branch cstack, R728
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R729

        R728:  # alt R730, R731
          push ustack, pos
          local_branch cstack, R730
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R731

        R730:  # alt R732, R733
          push ustack, pos
          local_branch cstack, R732
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R733

        R732:  # alt R734, R735
          push ustack, pos
          local_branch cstack, R734
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R735

        R734:  # alt R736, R737
          push ustack, pos
          local_branch cstack, R736
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R737

        R736:  # alt R738, R739
          push ustack, pos
          local_branch cstack, R738
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R739

        R738:  # alt R740, R741
          push ustack, pos
          local_branch cstack, R740
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R741

        R740:  # alt R742, R743
          push ustack, pos
          local_branch cstack, R742
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R743

        R742:  # alt R744, R745
          push ustack, pos
          local_branch cstack, R744
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R745

        R744:  # alt R746, R747
          push ustack, pos
          local_branch cstack, R746
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R747

        R746:  # alt R748, R749
          push ustack, pos
          local_branch cstack, R748
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R749

        R748:  # alt R750, R751
          push ustack, pos
          local_branch cstack, R750
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R751

        R750:  # alt R752, R753
          push ustack, pos
          local_branch cstack, R752
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R753

        R752:  # alt R754, R755
          push ustack, pos
          local_branch cstack, R754
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R755

        R754:  # alt R756, R757
          push ustack, pos
          local_branch cstack, R756
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R757

        R756:  # alt R758, R759
          push ustack, pos
          local_branch cstack, R758
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R759

        R758:  # alt R760, R761
          push ustack, pos
          local_branch cstack, R760
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R761

        R760:  # alt R762, R763
          push ustack, pos
          local_branch cstack, R762
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R763

        R762:  # alt R764, R765
          push ustack, pos
          local_branch cstack, R764
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R765

        R764:  # alt R766, R767
          push ustack, pos
          local_branch cstack, R766
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R767

        R766:  # alt R768, R769
          push ustack, pos
          local_branch cstack, R768
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R769

        R768:  # alt R770, R771
          push ustack, pos
          local_branch cstack, R770
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R771

        R770:  # alt R772, R773
          push ustack, pos
          local_branch cstack, R772
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R773

        R772:  # alt R774, R775
          push ustack, pos
          local_branch cstack, R774
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R775

        R774:  # alt R776, R777
          push ustack, pos
          local_branch cstack, R776
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R777

        R776:  # alt R778, R779
          push ustack, pos
          local_branch cstack, R778
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R779

        R778:  # alt R780, R781
          push ustack, pos
          local_branch cstack, R780
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R781

        R780:  # alt R782, R783
          push ustack, pos
          local_branch cstack, R782
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R783

        R782:  # alt R784, R785
          push ustack, pos
          local_branch cstack, R784
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R785

        R784:  # alt R786, R787
          push ustack, pos
          local_branch cstack, R786
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R787

        R786:  # alt R788, R789
          push ustack, pos
          local_branch cstack, R788
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R789

        R788:  # alt R790, R791
          push ustack, pos
          local_branch cstack, R790
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R791

        R790:  # alt R792, R793
          push ustack, pos
          local_branch cstack, R792
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R793

        R792:  # alt R794, R795
          push ustack, pos
          local_branch cstack, R794
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R795

        R794:  # alt R796, R797
          push ustack, pos
          local_branch cstack, R796
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R797

        R796:  # alt R798, R799
          push ustack, pos
          local_branch cstack, R798
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R799

        R798:  # alt R800, R801
          push ustack, pos
          local_branch cstack, R800
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R801

        R800:  # alt R802, R803
          push ustack, pos
          local_branch cstack, R802
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R803

        R802:  # alt R804, R805
          push ustack, pos
          local_branch cstack, R804
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R805

        R804:  # alt R806, R807
          push ustack, pos
          local_branch cstack, R806
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R807

        R806:  # alt R808, R809
          push ustack, pos
          local_branch cstack, R808
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R809

        R808:  # alt R810, R811
          push ustack, pos
          local_branch cstack, R810
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R811

        R810:  # alt R812, R813
          push ustack, pos
          local_branch cstack, R812
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R813

        R812:  # alt R814, R815
          push ustack, pos
          local_branch cstack, R814
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R815

        R814:  # alt R816, R817
          push ustack, pos
          local_branch cstack, R816
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R817

        R816:  # alt R818, R819
          push ustack, pos
          local_branch cstack, R818
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R819

        R818:  # alt R820, R821
          push ustack, pos
          local_branch cstack, R820
          pos = pop ustack
          if cutmark != 0 goto fail
          goto R821

        R820: # concat
        R822: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "++" goto fail
          pos += 2
          goto R823

        R823: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R821: # concat
        R824: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "--" goto fail
          pos += 2
          goto R825

        R825: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R819: # concat
        R826: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "+" goto fail
          pos += 1
          goto R827

        R827: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R817: # concat
        R828: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "-" goto fail
          pos += 1
          goto R829

        R829: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R815: # concat
        R830: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "*" goto fail
          pos += 1
          goto R831

        R831: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R813: # concat
        R832: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "/" goto fail
          pos += 1
          goto R833

        R833: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R811: # concat
        R834: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "<=" goto fail
          pos += 2
          goto R835

        R835: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R809: # concat
        R836: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != ">=" goto fail
          pos += 2
          goto R837

        R837: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R807: # concat
        R838: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "!=" goto fail
          pos += 2
          goto R839

        R839: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R805: # concat
        R840: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "=" goto fail
          pos += 1
          goto R841

        R841: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R803: # concat
        R842: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "<" goto fail
          pos += 1
          goto R843

        R843: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R801: # concat
        R844: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != ">" goto fail
          pos += 1
          goto R845

        R845: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R799: # concat
        R846: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "or" goto fail
          pos += 2
          goto R847

        R847: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R797: # concat
        R848: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "and" goto fail
          pos += 3
          goto R849

        R849: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R795: # concat
        R850: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "xor" goto fail
          pos += 3
          goto R851

        R851: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R793: # concat
        R852: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "div" goto fail
          pos += 3
          goto R853

        R853: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R791: # concat
        R854: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "rem" goto fail
          pos += 3
          goto R855

        R855: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R789: # concat
        R856: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "mod" goto fail
          pos += 3
          goto R857

        R857: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R787: # concat
        R858: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "cmp" goto fail
          pos += 3
          goto R859

        R859: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R785: # concat
        R860: # literal
          $I0 = pos + 13
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 13
          
          if $S0 != "setundeferror" goto fail
          pos += 13
          goto R861

        R861: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R783: # concat
        R862: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "undeferror" goto fail
          pos += 10
          goto R863

        R863: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R781: # concat
        R864: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "fputstring" goto fail
          pos += 10
          goto R865

        R865: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R779: # concat
        R866: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "condlinrec" goto fail
          pos += 10
          goto R867

        R867: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R777: # concat
        R868: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "treegenrec" goto fail
          pos += 10
          goto R869

        R869: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R775: # concat
        R870: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "helpdetail" goto fail
          pos += 10
          goto R871

        R871: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R773: # concat
        R872: # literal
          $I0 = pos + 10
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 10
          
          if $S0 != "setautoput" goto fail
          pos += 10
          goto R873

        R873: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R771: # concat
        R874: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "rolldownd" goto fail
          pos += 9
          goto R875

        R875: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R769: # concat
        R876: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "localtime" goto fail
          pos += 9
          goto R877

        R877: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R767: # concat
        R878: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "fputchars" goto fail
          pos += 9
          goto R879

        R879: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R765: # concat
        R880: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "construct" goto fail
          pos += 9
          goto R881

        R881: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R763: # concat
        R882: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "ifinteger" goto fail
          pos += 9
          goto R883

        R883: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R761: # concat
        R884: # literal
          $I0 = pos + 9
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 9
          
          if $S0 != "iflogical" goto fail
          pos += 9
          goto R885

        R885: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R759: # concat
        R886: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "rolldown" goto fail
          pos += 8
          goto R887

        R887: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R757: # concat
        R888: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "strftime" goto fail
          pos += 8
          goto R889

        R889: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R755: # concat
        R890: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "enconcat" goto fail
          pos += 8
          goto R891

        R891: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R753: # concat
        R892: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "ifstring" goto fail
          pos += 8
          goto R893

        R893: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R751: # concat
        R894: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "tostring" goto fail
          pos += 8
          goto R895

        R895: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R749: # concat
        R896: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "treestep" goto fail
          pos += 8
          goto R897

        R897: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R747: # concat
        R898: # literal
          $I0 = pos + 8
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 8
          
          if $S0 != "putchars" goto fail
          pos += 8
          goto R899

        R899: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R745: # concat
        R900: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "setsize" goto fail
          pos += 7
          goto R901

        R901: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R743: # concat
        R902: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "autoput" goto fail
          pos += 7
          goto R903

        R903: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R741: # concat
        R904: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "rollupd" goto fail
          pos += 7
          goto R905

        R905: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R739: # concat
        R906: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "rotated" goto fail
          pos += 7
          goto R907

        R907: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R737: # concat
        R908: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "formatf" goto fail
          pos += 7
          goto R909

        R909: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R735: # concat
        R910: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "fremove" goto fail
          pos += 7
          goto R911

        R911: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R733: # concat
        R912: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "frename" goto fail
          pos += 7
          goto R913

        R913: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R731: # concat
        R914: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "unstack" goto fail
          pos += 7
          goto R915

        R915: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R729: # concat
        R916: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "unswons" goto fail
          pos += 7
          goto R917

        R917: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R727: # concat
        R918: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "integer" goto fail
          pos += 7
          goto R919

        R919: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R725: # concat
        R920: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "logical" goto fail
          pos += 7
          goto R921

        R921: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R723: # concat
        R922: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "nullary" goto fail
          pos += 7
          goto R923

        R923: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R721: # concat
        R924: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "ternary" goto fail
          pos += 7
          goto R925

        R925: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R719: # concat
        R926: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "iffloat" goto fail
          pos += 7
          goto R927

        R927: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R717: # concat
        R928: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "tailrec" goto fail
          pos += 7
          goto R929

        R929: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R715: # concat
        R930: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "primrec" goto fail
          pos += 7
          goto R931

        R931: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R713: # concat
        R932: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "treerec" goto fail
          pos += 7
          goto R933

        R933: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R711: # concat
        R934: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "setecho" goto fail
          pos += 7
          goto R935

        R935: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R709: # concat
        R936: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "include" goto fail
          pos += 7
          goto R937

        R937: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R707: # concat
        R938: # literal
          $I0 = pos + 7
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 7
          
          if $S0 != "reverse" goto fail
          pos += 7
          goto R939

        R939: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R705: # concat
        R940: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "maxint" goto fail
          pos += 6
          goto R941

        R941: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R703: # concat
        R942: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "undefs" goto fail
          pos += 6
          goto R943

        R943: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R701: # concat
        R944: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "stdout" goto fail
          pos += 6
          goto R945

        R945: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R699: # concat
        R946: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "stderr" goto fail
          pos += 6
          goto R947

        R947: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R697: # concat
        R948: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "rollup" goto fail
          pos += 6
          goto R949

        R949: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R695: # concat
        R950: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "rotate" goto fail
          pos += 6
          goto R951

        R951: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R693: # concat
        R952: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "choice" goto fail
          pos += 6
          goto R953

        R953: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R691: # concat
        R954: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "gmtime" goto fail
          pos += 6
          goto R955

        R955: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R689: # concat
        R956: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "mktime" goto fail
          pos += 6
          goto R957

        R957: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R687: # concat
        R958: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "strtol" goto fail
          pos += 6
          goto R959

        R959: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R685: # concat
        R960: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "strtod" goto fail
          pos += 6
          goto R961

        R961: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R683: # concat
        R962: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "format" goto fail
          pos += 6
          goto R963

        R963: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R681: # concat
        R964: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fclose" goto fail
          pos += 6
          goto R965

        R965: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R679: # concat
        R966: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "ferror" goto fail
          pos += 6
          goto R967

        R967: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R677: # concat
        R968: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fflush" goto fail
          pos += 6
          goto R969

        R969: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R675: # concat
        R970: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fgetch" goto fail
          pos += 6
          goto R971

        R971: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R673: # concat
        R972: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fwrite" goto fail
          pos += 6
          goto R973

        R973: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R671: # concat
        R974: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "fputch" goto fail
          pos += 6
          goto R975

        R975: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R669: # concat
        R976: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "opcase" goto fail
          pos += 6
          goto R977

        R977: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R667: # concat
        R978: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "uncons" goto fail
          pos += 6
          goto R979

        R979: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R665: # concat
        R980: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "concat" goto fail
          pos += 6
          goto R981

        R981: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R663: # concat
        R982: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "intern" goto fail
          pos += 6
          goto R983

        R983: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R661: # concat
        R984: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "string" goto fail
          pos += 6
          goto R985

        R985: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R659: # concat
        R986: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "unary2" goto fail
          pos += 6
          goto R987

        R987: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R657: # concat
        R988: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "unary3" goto fail
          pos += 6
          goto R989

        R989: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R655: # concat
        R990: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "unary4" goto fail
          pos += 6
          goto R991

        R991: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R653: # concat
        R992: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "binary" goto fail
          pos += 6
          goto R993

        R993: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R651: # concat
        R994: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "cleave" goto fail
          pos += 6
          goto R995

        R995: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R649: # concat
        R996: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "branch" goto fail
          pos += 6
          goto R997

        R997: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R647: # concat
        R998: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "ifchar" goto fail
          pos += 6
          goto R999

        R999: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R645: # concat
        R1000: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "iflist" goto fail
          pos += 6
          goto R1001

        R1001: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R643: # concat
        R1002: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "iffile" goto fail
          pos += 6
          goto R1003

        R1003: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R641: # concat
        R1004: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "linrec" goto fail
          pos += 6
          goto R1005

        R1005: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R639: # concat
        R1006: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "binrec" goto fail
          pos += 6
          goto R1007

        R1007: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R637: # concat
        R1008: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "genrec" goto fail
          pos += 6
          goto R1009

        R1009: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R635: # concat
        R1010: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "filter" goto fail
          pos += 6
          goto R1011

        R1011: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R633: # concat
        R1012: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "manual" goto fail
          pos += 6
          goto R1013

        R1013: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R631: # concat
        R1014: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "system" goto fail
          pos += 6
          goto R1015

        R1015: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R629: # concat
        R1016: # literal
          $I0 = pos + 6
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 6
          
          if $S0 != "getenv" goto fail
          pos += 6
          goto R1017

        R1017: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R627: # concat
        R1018: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "print" goto fail
          pos += 5
          goto R1019

        R1019: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R625: # concat
        R1020: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "stack" goto fail
          pos += 5
          goto R1021

        R1021: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R623: # concat
        R1022: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "conts" goto fail
          pos += 5
          goto R1023

        R1023: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R621: # concat
        R1024: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "clock" goto fail
          pos += 5
          goto R1025

        R1025: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R619: # concat
        R1026: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "stdin" goto fail
          pos += 5
          goto R1027

        R1027: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R617: # concat
        R1028: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "swapd" goto fail
          pos += 5
          goto R1029

        R1029: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R615: # concat
        R1030: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "atan2" goto fail
          pos += 5
          goto R1031

        R1031: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R613: # concat
        R1032: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "floor" goto fail
          pos += 5
          goto R1033

        R1033: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R611: # concat
        R1034: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "frexp" goto fail
          pos += 5
          goto R1035

        R1035: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R609: # concat
        R1036: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "ldexp" goto fail
          pos += 5
          goto R1037

        R1037: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R607: # concat
        R1038: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "log10" goto fail
          pos += 5
          goto R1039

        R1039: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R605: # concat
        R1040: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "trunc" goto fail
          pos += 5
          goto R1041

        R1041: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R603: # concat
        R1042: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "srand" goto fail
          pos += 5
          goto R1043

        R1043: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R601: # concat
        R1044: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fgets" goto fail
          pos += 5
          goto R1045

        R1045: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R599: # concat
        R1046: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fopen" goto fail
          pos += 5
          goto R1047

        R1047: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R597: # concat
        R1048: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fread" goto fail
          pos += 5
          goto R1049

        R1049: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R595: # concat
        R1050: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "fseek" goto fail
          pos += 5
          goto R1051

        R1051: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R593: # concat
        R1052: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "ftell" goto fail
          pos += 5
          goto R1053

        R1053: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R591: # concat
        R1054: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "swons" goto fail
          pos += 5
          goto R1055

        R1055: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R589: # concat
        R1056: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "first" goto fail
          pos += 5
          goto R1057

        R1057: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R587: # concat
        R1058: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "small" goto fail
          pos += 5
          goto R1059

        R1059: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R585: # concat
        R1060: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "equal" goto fail
          pos += 5
          goto R1061

        R1061: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R583: # concat
        R1062: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "float" goto fail
          pos += 5
          goto R1063

        R1063: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R581: # concat
        R1064: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "app11" goto fail
          pos += 5
          goto R1065

        R1065: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R579: # concat
        R1066: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "app12" goto fail
          pos += 5
          goto R1067

        R1067: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R577: # concat
        R1068: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "unary" goto fail
          pos += 5
          goto R1069

        R1069: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R575: # concat
        R1070: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "ifset" goto fail
          pos += 5
          goto R1071

        R1071: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R573: # concat
        R1072: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "while" goto fail
          pos += 5
          goto R1073

        R1073: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R571: # concat
        R1074: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "times" goto fail
          pos += 5
          goto R1075

        R1075: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R569: # concat
        R1076: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "infra" goto fail
          pos += 5
          goto R1077

        R1077: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R567: # concat
        R1078: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "split" goto fail
          pos += 5
          goto R1079

        R1079: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R565: # concat
        R1080: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "putch" goto fail
          pos += 5
          goto R1081

        R1081: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R563: # concat
        R1082: # literal
          $I0 = pos + 5
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 5
          
          if $S0 != "abort" goto fail
          pos += 5
          goto R1083

        R1083: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R561: # concat
        R1084: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "echo" goto fail
          pos += 4
          goto R1085

        R1085: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R559: # concat
        R1086: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "time" goto fail
          pos += 4
          goto R1087

        R1087: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R557: # concat
        R1088: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "rand" goto fail
          pos += 4
          goto R1089

        R1089: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R555: # concat
        R1090: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "swap" goto fail
          pos += 4
          goto R1091

        R1091: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R553: # concat
        R1092: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "popd" goto fail
          pos += 4
          goto R1093

        R1093: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R551: # concat
        R1094: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "dupd" goto fail
          pos += 4
          goto R1095

        R1095: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R549: # concat
        R1096: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "sign" goto fail
          pos += 4
          goto R1097

        R1097: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R547: # concat
        R1098: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "acos" goto fail
          pos += 4
          goto R1099

        R1099: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R545: # concat
        R1100: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "asin" goto fail
          pos += 4
          goto R1101

        R1101: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R543: # concat
        R1102: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "atan" goto fail
          pos += 4
          goto R1103

        R1103: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R541: # concat
        R1104: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "ceil" goto fail
          pos += 4
          goto R1105

        R1105: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R539: # concat
        R1106: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "cosh" goto fail
          pos += 4
          goto R1107

        R1107: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R537: # concat
        R1108: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "modf" goto fail
          pos += 4
          goto R1109

        R1109: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R535: # concat
        R1110: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "sinh" goto fail
          pos += 4
          goto R1111

        R1111: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R533: # concat
        R1112: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "sqrt" goto fail
          pos += 4
          goto R1113

        R1113: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R531: # concat
        R1114: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "tanh" goto fail
          pos += 4
          goto R1115

        R1115: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R529: # concat
        R1116: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "pred" goto fail
          pos += 4
          goto R1117

        R1117: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R527: # concat
        R1118: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "succ" goto fail
          pos += 4
          goto R1119

        R1119: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R525: # concat
        R1120: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "feof" goto fail
          pos += 4
          goto R1121

        R1121: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R523: # concat
        R1122: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "fput" goto fail
          pos += 4
          goto R1123

        R1123: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R521: # concat
        R1124: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "cons" goto fail
          pos += 4
          goto R1125

        R1125: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R519: # concat
        R1126: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "rest" goto fail
          pos += 4
          goto R1127

        R1127: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R517: # concat
        R1128: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "size" goto fail
          pos += 4
          goto R1129

        R1129: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R515: # concat
        R1130: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "case" goto fail
          pos += 4
          goto R1131

        R1131: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R513: # concat
        R1132: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "drop" goto fail
          pos += 4
          goto R1133

        R1133: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R511: # concat
        R1134: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "take" goto fail
          pos += 4
          goto R1135

        R1135: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R509: # concat
        R1136: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "name" goto fail
          pos += 4
          goto R1137

        R1137: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R507: # concat
        R1138: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "body" goto fail
          pos += 4
          goto R1139

        R1139: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R505: # concat
        R1140: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "null" goto fail
          pos += 4
          goto R1141

        R1141: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R503: # concat
        R1142: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "char" goto fail
          pos += 4
          goto R1143

        R1143: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R501: # concat
        R1144: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "list" goto fail
          pos += 4
          goto R1145

        R1145: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R499: # concat
        R1146: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "leaf" goto fail
          pos += 4
          goto R1147

        R1147: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R497: # concat
        R1148: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "user" goto fail
          pos += 4
          goto R1149

        R1149: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R495: # concat
        R1150: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "file" goto fail
          pos += 4
          goto R1151

        R1151: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R493: # concat
        R1152: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "app1" goto fail
          pos += 4
          goto R1153

        R1153: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R491: # concat
        R1154: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "ifte" goto fail
          pos += 4
          goto R1155

        R1155: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R489: # concat
        R1156: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "cond" goto fail
          pos += 4
          goto R1157

        R1157: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R487: # concat
        R1158: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "step" goto fail
          pos += 4
          goto R1159

        R1159: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R485: # concat
        R1160: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "fold" goto fail
          pos += 4
          goto R1161

        R1161: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R483: # concat
        R1162: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "some" goto fail
          pos += 4
          goto R1163

        R1163: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R481: # concat
        R1164: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "help" goto fail
          pos += 4
          goto R1165

        R1165: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R479: # concat
        R1166: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "argv" goto fail
          pos += 4
          goto R1167

        R1167: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R477: # concat
        R1168: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "argc" goto fail
          pos += 4
          goto R1169

        R1169: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R475: # concat
        R1170: # literal
          $I0 = pos + 4
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 4
          
          if $S0 != "quit" goto fail
          pos += 4
          goto R1171

        R1171: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R473: # concat
        R1172: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "dup" goto fail
          pos += 3
          goto R1173

        R1173: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R471: # concat
        R1174: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "pop" goto fail
          pos += 3
          goto R1175

        R1175: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R469: # concat
        R1176: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "not" goto fail
          pos += 3
          goto R1177

        R1177: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R467: # concat
        R1178: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "neg" goto fail
          pos += 3
          goto R1179

        R1179: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R465: # concat
        R1180: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "ord" goto fail
          pos += 3
          goto R1181

        R1181: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R463: # concat
        R1182: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "chr" goto fail
          pos += 3
          goto R1183

        R1183: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R461: # concat
        R1184: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "abs" goto fail
          pos += 3
          goto R1185

        R1185: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R459: # concat
        R1186: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "cos" goto fail
          pos += 3
          goto R1187

        R1187: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R457: # concat
        R1188: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "exp" goto fail
          pos += 3
          goto R1189

        R1189: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R455: # concat
        R1190: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "log" goto fail
          pos += 3
          goto R1191

        R1191: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R453: # concat
        R1192: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "pow" goto fail
          pos += 3
          goto R1193

        R1193: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R451: # concat
        R1194: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "sin" goto fail
          pos += 3
          goto R1195

        R1195: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R449: # concat
        R1196: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "tan" goto fail
          pos += 3
          goto R1197

        R1197: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R447: # concat
        R1198: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "max" goto fail
          pos += 3
          goto R1199

        R1199: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R445: # concat
        R1200: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "min" goto fail
          pos += 3
          goto R1201

        R1201: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R443: # concat
        R1202: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "has" goto fail
          pos += 3
          goto R1203

        R1203: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R441: # concat
        R1204: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "set" goto fail
          pos += 3
          goto R1205

        R1205: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R439: # concat
        R1206: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "dip" goto fail
          pos += 3
          goto R1207

        R1207: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R437: # concat
        R1208: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "map" goto fail
          pos += 3
          goto R1209

        R1209: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R435: # concat
        R1210: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "all" goto fail
          pos += 3
          goto R1211

        R1211: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R433: # concat
        R1212: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "get" goto fail
          pos += 3
          goto R1213

        R1213: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R431: # concat
        R1214: # literal
          $I0 = pos + 3
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 3
          
          if $S0 != "put" goto fail
          pos += 3
          goto R1215

        R1215: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R429: # concat
        R1216: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "id" goto fail
          pos += 2
          goto R1217

        R1217: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R427: # concat
        R1218: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "at" goto fail
          pos += 2
          goto R1219

        R1219: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R425: # concat
        R1220: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "of" goto fail
          pos += 2
          goto R1221

        R1221: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R423: # concat
        R1222: # literal
          $I0 = pos + 2
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 2
          
          if $S0 != "in" goto fail
          pos += 2
          goto R1223

        R1223: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R421: # concat
        R1224: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "i" goto fail
          pos += 1
          goto R1225

        R1225: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R419: # concat
        R1226: # literal
          $I0 = pos + 1
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 1
          
          if $S0 != "x" goto fail
          pos += 1
          goto R1227

        R1227: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R417: # concat
        R1228: # literal
          $I0 = pos + 16
          if $I0 > lastpos goto fail
          $S0 = substr target, pos, 16
          
          if $S0 != "ban-space-kimchi" goto fail
          pos += 16
          goto R1229

        R1229: # action
          $P1 = adverbs['action']
          if null $P1 goto R415
          $I1 = can $P1, "builtins"
          if $I1 == 0 goto R415
          mpos = pos
          $P1."builtins"(mob)
          goto R415
        R415: # cut 410
          local_branch cstack, R412
          cutmark = 410
          goto fail

        R412: # subrule before
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'before'
          if $I0 == 0 goto R412_1
          $P0 = find_method mob, 'before'
          goto R412_2
        R412_1:
          $P0 = find_name 'before'
          unless null $P0 goto R412_2
          say "Unable to find regex 'before'"
        R412_2:
          captob = $P0(captob, "[ \\s | '[' | ']' | '.' ]")
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          $P1 = pos
          $P1 = getattribute captob, '$.from'
          $P1 = pos
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
        R1230: # subrule funcname
          captob = captscope
          $P0 = getattribute captob, '$.pos'
          $P0 = pos
          $I0 = can mob, 'funcname'
          if $I0 == 0 goto R1230_1
          $P0 = find_method mob, 'funcname'
          goto R1230_2
        R1230_1:
          $P0 = find_name 'funcname'
          unless null $P0 goto R1230_2
          say "Unable to find regex 'funcname'"
        R1230_2:
          $P2 = adverbs['action']
          captob = $P0(captob, 'action'=>$P2)
          $P1 = getattribute captob, '$.pos'
          if $P1 <= -3 goto fail_match
          if $P1 < 0 goto fail
          
          captscope["funcname"] = captob

          pos = $P1
          local_branch cstack, R1231
          delete captscope["funcname"]

          goto fail
        R1231: # action
          $P1 = adverbs['action']
          if null $P1 goto succeed
          $I1 = can $P1, "userfunccall"
          if $I1 == 0 goto succeed
          mpos = pos
          $P1."userfunccall"(mob)
          goto succeed
      .end
