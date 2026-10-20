/* mid__copy_bssid_8e211c @ 0x8e211c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr_mac_start_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.mid__copy_bssid_8e211c,"ax",@progbits
	.global mid__copy_bssid_8e211c
mid__copy_bssid_8e211c:
	.global L_8e211c
L_8e211c:
	add3 r2,r0,0x2c
L_8e2120:
	mov_s r0,r1
L_8e2122:
	add r1,r2,0x1b
L_8e2126:
	b.d L_8c0460
L_8e212a:
	mov_s r2,0x3
