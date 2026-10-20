/* rfc__select_chain_and_write @ 0x8d3110, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: set_g_8000fc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_abif__rgf_889480_8cd28c, hwd_abif__rgf_88af00, hwd_abif__set_3bit_chain_sel, rfc__write_field_484, set_g_800216
 */
	.section .text.rfc__select_chain_and_write,"ax",@progbits
	.global rfc__select_chain_and_write
rfc__select_chain_and_write:
	.global L_8d3110
L_8d3110:
	push_s blink
L_8d3112:
	bl L_8c02c0
L_8d3116:
	mov_s r15,r1
L_8d3118:
	mov_s r14,r2
L_8d311a:
	bl.d L_8cd34c
L_8d311e:
	mov_s r13,r3
L_8d3120:
	bl.d L_8cd2d0
L_8d3124:
	mov_s r0,r15
L_8d3126:
	bl.d L_8d0e38
L_8d312a:
	mov_s r0,r13
L_8d312c:
	bl.d L_8cd28c
L_8d3130:
	mov_s r0,r13
L_8d3132:
	mov_s r0,0x0
L_8d3134:
	bl.d L_8d0e40
L_8d3138:
	mov_s r1,r14
L_8d313a:
	.byte 0xf5,0x01
