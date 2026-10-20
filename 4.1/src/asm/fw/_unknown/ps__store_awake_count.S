/* ps__store_awake_count @ 0x8c3604, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__awake_peers_evt
 */
	.section .text.ps__store_awake_count,"ax",@progbits
	.global ps__store_awake_count
ps__store_awake_count:
	.global L_8c3604
L_8c3604:
	mov_s r2,r0
L_8c3606:
	ldb_s r0,[r0,0x2]
L_8c3608:
	stb r0,[gp, 0xc6]
L_8c360c:
	ld_s r0,[gp,-0x58]
L_8c360e:
	ld_s r1,[r0,0x8]
L_8c3610:
	ld_s r3,[r1,0x8]
L_8c3612:
	j_s.d [r3]
