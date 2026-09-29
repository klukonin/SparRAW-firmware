/* wmi_add_key__pick_mid @ 0x8cbb2c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_add_cipher_key
 * Зовёт сам: __ld_r13_to_r13_ret, conn_mgr__first_active, mid__count_active_conns
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_add_key__pick_mid
wmi_add_key__pick_mid:
	.global L_8cbb2c
L_8cbb2c:
	push_s blink
L_8cbb2e:
	push_s r13
L_8cbb30:
	mov_s r13,r0
L_8cbb32:
	ld_s r0,[r0,0x18]
L_8cbb34:
	cmp_s r0,0x0
L_8cbb36:
	mov_s r0,0x1
L_8cbb38:
	sub_s.ne r0,r0,r0
L_8cbb3a:
	extb.f 0x0,r0
L_8cbb3e:
	bne_s L_8cbb48
L_8cbb40:
	bl.d L_8cc66c
L_8cbb44:
	mov_s r0,r13
L_8cbb46:
	brne_s r0,0,L_8cbb4c
	.global L_8cbb48
L_8cbb48:
	mov_s r0,0x0
L_8cbb4a:
	b_s L_8cbb52
	.global L_8cbb4c
L_8cbb4c:
	bl.d L_8cc254
L_8cbb50:
	mov_s r0,r13
	.global L_8cbb52
L_8cbb52:
	b L_8c025c
L_8cbb56:
	nop_s
