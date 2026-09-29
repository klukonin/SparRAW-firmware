/* ucode_cmd_trigger_bf @ 0x922268, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__trigger, uc_tx__is_idle, ucode_pm__set_busy_flag
 * Глобалы (через gp): 0x8005ec
 */
	.section .text.ucode_cmd_trigger_bf,"ax",@progbits
	.global ucode_cmd_trigger_bf
ucode_cmd_trigger_bf:
	.global L_922268
L_922268:
	push_s blink
L_92226a:
	push_s r13
L_92226c:
	mov_s r13,r0
L_92226e:
	ld_s r0,[gp,0xc4]
L_922270:
	breq r0,0x1,L_92227e
L_922274:
	mov_s r0,r13
L_922276:
	bl.d L_9222cc
L_92227a:
	mov_s r1,0x1
L_92227c:
	b_s L_92229c
	.global L_92227e
L_92227e:
	bl.d L_936d50
L_922282:
	mov_s r0,0x0
L_922284:
	bl L_936b2c
L_922288:
	ld_s r0,[r13,0x8]
L_92228a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92228c:
	add2_s r0,r0,r0
L_92228e:
	add r1,r0,0x857838
L_922296:
	ldb_s r0,[r1,0x11]
L_922298:
	bset_s r0,r0,0x4
L_92229a:
	stb_s r0,[r1,0x11]
	.global L_92229c
L_92229c:
	b L_92028c
