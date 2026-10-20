/* ucode_cmd__apply_mac_cfg @ 0x92b828, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 * Зовёт сам: __ld_r13_ret_uc, mac__program_886e0c_20b, memcpy_uc
 */
	.section .text.ucode_cmd__apply_mac_cfg,"ax",@progbits
	.global ucode_cmd__apply_mac_cfg
ucode_cmd__apply_mac_cfg:
	.global L_92b828
L_92b828:
	push_s blink
L_92b82a:
	push_s r13
L_92b82c:
	mov_s r1,r0
L_92b82e:
	mov_s r13,0x801660
L_92b834:
	mov_s r0,r13
L_92b836:
	bl.d L_920310
L_92b83a:
	mov_s r2,0x30
L_92b83c:
	bl.d L_92b6a8
L_92b840:
	mov_s r0,r13
L_92b842:
	b L_92028c
L_92b846:
	nop_s
