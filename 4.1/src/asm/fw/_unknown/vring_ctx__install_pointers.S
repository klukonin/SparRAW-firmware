/* vring_ctx__install_pointers @ 0x8c1938, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.vring_ctx__install_pointers,"ax",@progbits
	.global vring_ctx__install_pointers
vring_ctx__install_pointers:
L_8c1938:
	mov_s r1,0x842530
L_8c193e:
	mov_s r3,0x80084c
L_8c1944:
	st_s r3,[r1,0x50]
L_8c1946:
	mov_s r2,0x800718
L_8c194c:
	st_s r2,[r1,0x6c]
L_8c194e:
	mov_s r0,0x8006bc
L_8c1954:
	st_s r0,[r1,0x4c]
L_8c1956:
	mov_s r1,0x842404
L_8c195c:
	st r3,[r1, 0xec]
L_8c1960:
	st.as r2,[r1,0x42]
L_8c1964:
	st r0,[r1, 0xe8]
L_8c1968:
	st_s r3,[r1,0x5c]
L_8c196a:
	st_s r2,[r1,0x78]
L_8c196c:
	j_s.d [blink]
L_8c196e:
	st_s r0,[r1,0x58]
