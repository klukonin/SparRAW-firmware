/* hwd_phy__set_883000 @ 0x8cfc70, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__get_883100
 */
	.section .text.hwd_phy__set_883000,"ax",@progbits
	.global hwd_phy__set_883000
hwd_phy__set_883000:
	.global L_8cfc70
L_8cfc70:
	mov_s r2,0x883000
L_8cfc76:
	st.as r0,[r2,0x4b]
L_8cfc7a:
	st.as r1,[r2,0x73]
L_8cfc7e:
	j_s [blink]
