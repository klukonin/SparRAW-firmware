/* scan_mngr__update_step @ 0x8cbee8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__field_18_step, scan_mngr__update_connected_scan_time
 * Зовёт сам: __ld_r13_to_r13_ret, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__update_step
scan_mngr__update_step:
	.global L_8cbee8
L_8cbee8:
	push_s blink
L_8cbeea:
	push_s r13
L_8cbeec:
	ld_s r1,[r0,0x78]
L_8cbeee:
	sub_s sp,sp,0x8
L_8cbef0:
	mov_s r13,r0
L_8cbef2:
	add r13,r13,0x200
L_8cbef6:
	brne_s r1,0,L_8cbefc
L_8cbef8:
	ld_s r0,[r13,0x18]
L_8cbefa:
	b_s L_8cbf10
	.global L_8cbefc
L_8cbefc:
	mov_s r1,sp
L_8cbefe:
	mov_s r0,0x0
L_8cbf00:
	bl.d L_8e9900
L_8cbf04:
	mov_s r2,r0
L_8cbf06:
	ld_s r0,[r13,0x1c]
L_8cbf08:
	ld_s r1,[sp,0x0]
L_8cbf0a:
	sub_s r1,r1,r0
L_8cbf0c:
	ld_s r0,[r13,0x18]
L_8cbf0e:
	add_s r0,r0,r1
	.global L_8cbf10
L_8cbf10:
	b.d L_8c025c
L_8cbf14:
	add_s sp,sp,0x8
L_8cbf16:
	nop_s
