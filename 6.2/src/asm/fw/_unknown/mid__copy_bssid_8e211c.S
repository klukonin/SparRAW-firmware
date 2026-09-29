/* mid__copy_bssid_8e211c @ 0x8ccea4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_cap__build_sta_capability
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__copy_bssid_8e211c
mid__copy_bssid_8e211c:
	.global L_8ccea4
L_8ccea4:
	add3 r2,r0,0x2c
L_8ccea8:
	mov_s r0,r1
L_8cceaa:
	add r1,r2,0x1b
L_8cceae:
	b.d L_8c0380
L_8cceb2:
	mov_s r2,0x3
