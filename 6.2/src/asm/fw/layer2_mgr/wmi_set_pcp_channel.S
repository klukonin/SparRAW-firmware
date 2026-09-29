/* wmi_set_pcp_channel @ 0x8fbcc4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_pcp_channel
wmi_set_pcp_channel:
	.global L_8fbcc4
L_8fbcc4:
	push_s blink
L_8fbcc6:
	push_s r13
L_8fbcc8:
	mov_s r13,r0
L_8fbcca:
	ldb_s r0,[r0]
L_8fbccc:
	brge r0,0x4,L_8fbcde
	.global L_8fbcd0
L_8fbcd0:
	ldb_s r1,[r13]
L_8fbcd2:
	mov_s r0,0x803b80
L_8fbcd8:
	b.d L_8c025c
L_8fbcdc:
	st_s r1,[r0]
	.global L_8fbcde
L_8fbcde:
	mov_s r0,blink
L_8fbce0:
	mov_s r1,0x11df
L_8fbce6:
	bl L_8c9b28
L_8fbcea:
	b_s L_8fbcd0
