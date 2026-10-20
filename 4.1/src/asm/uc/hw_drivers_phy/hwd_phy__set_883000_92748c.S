/* hwd_phy__set_883000_92748c @ 0x92748c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc_ctrl__switch
 */
	.section .text.hwd_phy__set_883000_92748c,"ax",@progbits
	.global hwd_phy__set_883000_92748c
hwd_phy__set_883000_92748c:
	.global L_92748c
L_92748c:
	mov_s r2,0x883000
L_927492:
	st.as r0,[r2,0x4b]
L_927496:
	st.as r1,[r2,0x73]
L_92749a:
	j_s [blink]
