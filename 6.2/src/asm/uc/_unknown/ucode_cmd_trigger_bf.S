/* ucode_cmd_trigger_bf @ 0x921990, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, bf_init_sm, uc_tx__is_idle, ucode_pm__set_busy_flag
 * Глобалы (через gp): 0x8005dc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_trigger_bf
ucode_cmd_trigger_bf:
	.global L_921990
L_921990:
	push_s blink
L_921992:
	push_s r13
L_921994:
	mov_s r13,r0
L_921996:
	ld_s r0,[gp,0xb4]
L_921998:
	breq r0,0x1,L_9219a6
L_92199c:
	mov_s r0,r13
L_92199e:
	bl.d L_9219f4
L_9219a2:
	mov_s r1,0x1
L_9219a4:
	b_s L_9219c4
	.global L_9219a6
L_9219a6:
	bl.d L_93c874
L_9219aa:
	mov_s r0,0x0
L_9219ac:
	bl L_93c658
L_9219b0:
	ld_s r0,[r13,0x8]
L_9219b2:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9219b4:
	add2_s r0,r0,r0
L_9219b6:
	add r1,r0,0x857e38
L_9219be:
	ldb_s r0,[r1,0x11]
L_9219c0:
	bset_s r0,r0,0x4
L_9219c2:
	stb_s r0,[r1,0x11]
	.global L_9219c4
L_9219c4:
	b L_9202ac
