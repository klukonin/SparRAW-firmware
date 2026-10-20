/* phy__read_regs_883844 @ 0x929ea8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4, rx_resp__finish_restore_rx
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy__read_regs_883844
phy__read_regs_883844:
	.global L_929ea8
L_929ea8:
	cmp_s r1,0x0
L_929eaa:
	jls [blink]
L_929eae:
	mov_s lp_count,r1
L_929eb0:
	mov r3,0x883844
L_929eb8:
	lp L_929ec4
L_929ebc:
	ld.ab r2,[r3,0x4]
L_929ec0:
	st.ab r2,[r0,0x4]
	.global L_929ec4
L_929ec4:
	j_s [blink]
L_929ec6:
	nop_s
