/* ftm__set_shared_active_flag @ 0x8cb544, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_connection_by_addr, state_sm_803424__action_8f064c, state_sm_803424__action_8f0a10, state_sm_803424__action_cmp12
 * Зовёт сам: tof_mgr__ftm_req_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm__set_shared_active_flag
ftm__set_shared_active_flag:
	.global L_8cb544
L_8cb544:
	mov_s r1,0x857680
L_8cb54a:
	j_s.d [blink]
L_8cb54c:
	st_s r0,[r1,0x28]
L_8cb54e:
	nop_s
	.global L_8cb550
L_8cb550:
	push_s blink
L_8cb552:
	bl.d L_8cb2bc
L_8cb556:
	ld_s r0,[gp,-0x74]
L_8cb558:
	mov_s r0,0x1
L_8cb55a:
	pop_s blink
L_8cb55c:
	j_s [blink]
L_8cb55e:
	nop_s
