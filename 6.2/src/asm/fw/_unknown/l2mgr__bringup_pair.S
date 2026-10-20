/* l2mgr__bringup_pair @ 0x8dd8d0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_phy__rx_enable, hwd_phy__tx_enable
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__bringup_pair
l2mgr__bringup_pair:
	.global L_8dd8d0
L_8dd8d0:
	push_s blink
L_8dd8d2:
	push_s r13
L_8dd8d4:
	bl.d L_8d21d0
L_8dd8d8:
	mov_s r13,r0
L_8dd8da:
	bl.d L_8d219c
L_8dd8de:
	mov_s r0,r13
L_8dd8e0:
	b L_8c025c
