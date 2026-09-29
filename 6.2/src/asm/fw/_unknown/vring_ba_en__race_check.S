/* vring_ba_en__race_check @ 0x8c4240, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW-DRIVER race. WMI_VRING_BA_EN_CMD for vring: %d, after disconnect - ignoring
 *   FW-DRIVER race. WMI_VRING_BA_EN_CMD for vring: %d, DURING disconnect - ignoring
 * Зовут его: wmi_vring_ba_en
 * Зовёт сам: __ld_r13_to_r13_ret, ba_sm_evt_type, fw_log_emit1, send_ba_status_report
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_ba_en__race_check
vring_ba_en__race_check:
	.global L_8c4240
L_8c4240:
	push_s blink
L_8c4242:
	push_s r13
L_8c4244:
	mov_s r13,r0
L_8c4246:
	mov_s r0,0x847f34
L_8c424c:
	sub r0,r0,0x400
L_8c4250:
	add2_s r0,r0,r13
L_8c4252:
	ld r0,[r0,0x44c]
L_8c425a:
	mov_s r5,r2
L_8c425c:
	mov_s r6,r1
L_8c425e:
	mov_s r4,r3
L_8c4260:
	brne_s r0,0,L_8c4272
L_8c4262:
	mov_s r1,0x1010b94
	.global L_8c4268
L_8c4268:
	mov_s r0,0x2b
L_8c426a:
	bl.d L_8dcc10
L_8c426e:
	mov_s r2,r13
L_8c4270:
	b_s L_8c428e
	.global L_8c4272
L_8c4272:
	ld_s r1,[r0,0x58]
L_8c4274:
	brne r1,0x1,L_8c4280
L_8c4278:
	mov_s r1,0x1010be4
L_8c427e:
	b_s L_8c4268
	.global L_8c4280
L_8c4280:
	mov_s r1,0x1
L_8c4282:
	st_s r1,[r0,0x54]
L_8c4284:
	mov_s r1,0x0
L_8c4286:
	mov_s r2,r6
L_8c4288:
	bl.d L_8d9c4c
L_8c428c:
	mov_s r3,r5
	.global L_8c428e
L_8c428e:
	b L_8c025c
L_8c4292:
	nop_s
L_8c4294:
	mov_s r2,r1
L_8c4296:
	ldb_s r1,[r0,0x7]
L_8c4298:
	mov_s r3,0x0
L_8c429a:
	mov_s r4,r3
L_8c429c:
	b.d L_8e5174
L_8c42a0:
	mov_s r5,r3
L_8c42a2:
	nop_s
