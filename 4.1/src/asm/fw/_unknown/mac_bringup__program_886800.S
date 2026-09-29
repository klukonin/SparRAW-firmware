/* mac_bringup__program_886800 @ 0x8ee720, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.mac_bringup__program_886800,"ax",@progbits
	.global mac_bringup__program_886800
mac_bringup__program_886800:
	.global L_8ee720
L_8ee720:
	mov_s r0,0x1f
L_8ee722:
	mov_s r1,0x886800
L_8ee728:
	st.as r0,[r1,-0xf2]
L_8ee72c:
	st.as r0,[r1,-0xed]
L_8ee730:
	mov_s r2,0x886000
L_8ee736:
	st.as 0xa3ff,[r2,0x84]
L_8ee73e:
	st.as 0xa3ff,[r2,0x89]
L_8ee746:
	mov_s r0,0x3
L_8ee748:
	st.as r0,[r1,-0xbe]
L_8ee74c:
	st.as r0,[r1,-0xb9]
L_8ee750:
	mov_s r0,0x7
L_8ee752:
	st_s r0,[r1,0x40]
L_8ee754:
	st_s r0,[r1,0x54]
L_8ee756:
	mov r0,-0x78
L_8ee75a:
	st_s r0,[r2,0x28]
L_8ee75c:
	j_s [blink]
L_8ee75e:
	nop_s
