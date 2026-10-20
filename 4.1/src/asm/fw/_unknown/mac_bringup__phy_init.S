/* mac_bringup__phy_init @ 0x8d9b44, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_ret, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_884000
 */
	.section .text.mac_bringup__phy_init,"ax",@progbits
	.global mac_bringup__phy_init
mac_bringup__phy_init:
	.global L_8d9b44
L_8d9b44:
	push_s blink
L_8d9b46:
	push_s r13
L_8d9b48:
	bl.d L_8cf4fc
L_8d9b4c:
	mov_s r13,r0
L_8d9b4e:
	bl.d L_8cf4c8
L_8d9b52:
	mov_s r0,r13
L_8d9b54:
	b L_8c033c
