/* ucode_cmd_0x1b_handler @ 0x92b250, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 */
	.section .text.ucode_cmd_0x1b_handler,"ax",@progbits
	.global ucode_cmd_0x1b_handler
ucode_cmd_0x1b_handler:
	.global L_92b250
L_92b250:
	lr r1,[0xa]
L_92b254:
	bclr r2,r1,0x1
L_92b258:
	flag r2
L_92b25c:
	ldb_s r2,[r0,0x1]
L_92b25e:
	bic r1,r1,-0x3
L_92b262:
	st.as r2,[gp,-0x13]
L_92b266:
	ldb_s r2,[r0]
L_92b268:
	mov_s r0,0x8009cc
L_92b26e:
	st_s r2,[r0,0x1c]
L_92b270:
	lr r0,[0xa]
L_92b274:
	or_s r1,r1,r0
L_92b276:
	flag r1
L_92b27a:
	j_s [blink]
