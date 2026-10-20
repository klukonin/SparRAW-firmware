/* table_8430b0__install_pointers @ 0x8c17e8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.table_8430b0__install_pointers,"ax",@progbits
	.global table_8430b0__install_pointers
table_8430b0__install_pointers:
L_8c17e8:
	mov_s r1,0x8430b0
L_8c17ee:
	mov_s r0,0x800664
L_8c17f4:
	st_s r0,[r1,0x8]
L_8c17f6:
	mov_s r0,0x800604
L_8c17fc:
	st_s r0,[r1,0x14]
L_8c17fe:
	mov_s r0,0x8005a4
L_8c1804:
	st_s r0,[r1,0x20]
L_8c1806:
	mov_s r0,0x8006cc
L_8c180c:
	st_s r0,[r1,0x2c]
L_8c180e:
	mov_s r0,0x8005d4
L_8c1814:
	st_s r0,[r1,0x38]
L_8c1816:
	mov_s r0,0x800634
L_8c181c:
	j_s.d [blink]
L_8c181e:
	st_s r0,[r1,0x44]
