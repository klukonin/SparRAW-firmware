/* wmi_vring_ba_en @ 0x8fb4b4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, vring_ba_en__race_check
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_vring_ba_en
wmi_vring_ba_en:
	.global L_8fb4b4
L_8fb4b4:
	push_s blink
L_8fb4b6:
	bl L_8c01e4
L_8fb4ba:
	ldb_s r14,[r0]
L_8fb4bc:
	brhs.d r14,0xa,L_8fb4d2
L_8fb4c0:
	mov_s r13,r0
	.global L_8fb4c2
L_8fb4c2:
	ldb_s r1,[r13,0x1]
L_8fb4c4:
	mov_s r0,r14
L_8fb4c6:
	ldw_s r2,[r13,0x2]
L_8fb4c8:
	bl.d L_8c4240
L_8fb4cc:
	ldb_s r3,[r13,0x4]
L_8fb4ce:
	b L_8c0254
	.global L_8fb4d2
L_8fb4d2:
	mov_s r0,blink
L_8fb4d4:
	mov_s r1,0x11dd
L_8fb4da:
	bl L_8c9b28
L_8fb4de:
	b_s L_8fb4c2
