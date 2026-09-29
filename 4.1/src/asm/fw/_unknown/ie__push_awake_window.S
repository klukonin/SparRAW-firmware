/* ie__push_awake_window @ 0x8ef82c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.ie__push_awake_window,"ax",@progbits
	.global ie__push_awake_window
ie__push_awake_window:
	.global L_8ef82c
L_8ef82c:
	sub_s sp,sp,0x4
L_8ef82e:
	push_s blink
L_8ef830:
	stw r1,[sp, 0x4]
L_8ef834:
	mov_s r1,0x9d
L_8ef836:
	stb_s r1,[r0]
L_8ef838:
	mov_s r2,0x2
L_8ef83a:
	stb_s r2,[r0,0x1]
L_8ef83c:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ef83e:
	bl.d L_8c0460
L_8ef842:
	add_s r1,sp,0x4
L_8ef844:
	mov_s r0,0x4
L_8ef846:
	pop_s blink
L_8ef848:
	j_s.d [blink]
L_8ef84a:
	add_s sp,sp,0x4
