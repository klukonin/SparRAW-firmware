/* rm_main_sm__enter_primary_non_locked @ 0x8c80c8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::enter_primary_non_locked. Primary Mismatch, retuning...
 * Зовут его: radio_manager_main_sm__on_ch_switch_done
 * Зовёт сам: __ld_r13_ret, basic_sm__store_pending_event, fw_log__emit0, rm__channel_matches
 */
	.section .text.rm_main_sm__enter_primary_non_locked,"ax",@progbits
	.global rm_main_sm__enter_primary_non_locked
rm_main_sm__enter_primary_non_locked:
	.global L_8c80c8
L_8c80c8:
	push_s blink
L_8c80ca:
	push_s r13
L_8c80cc:
	mov_s r13,r0
L_8c80ce:
	add_s r0,r0,0x74
L_8c80d0:
	bl.d L_8d7314
L_8c80d4:
	add2 r1,r13,0x27
L_8c80d8:
	breq_s r0,0,L_8c80e0
L_8c80da:
	ld r0,[r13, 0x88]
L_8c80de:
	breq_s r0,0,L_8c80f8
	.global L_8c80e0
L_8c80e0:
	ld_s r0,[r13,0x28]
L_8c80e2:
	breq_s r0,0,L_8c80f2
L_8c80e4:
	mov_s r2,0x1015de0
L_8c80ea:
	mov_s r0,0x8
L_8c80ec:
	bl.d L_8edfb0
L_8c80f0:
	mov_s r1,0x2
	.global L_8c80f2
L_8c80f2:
	mov_s r0,r13
L_8c80f4:
	mov_s r1,0x1
L_8c80f6:
	b_s L_8c80fc
	.global L_8c80f8
L_8c80f8:
	mov_s r0,r13
L_8c80fa:
	mov_s r1,0x3
	.global L_8c80fc
L_8c80fc:
	mov_s r2,0x0
L_8c80fe:
	mov_s r3,r2
L_8c8100:
	bl.d L_8e20c0
L_8c8104:
	mov_s r4,r2
L_8c8106:
	.byte 0x39,0x02
