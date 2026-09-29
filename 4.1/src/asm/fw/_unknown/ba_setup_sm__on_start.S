/* ba_setup_sm__on_start @ 0x8ed558, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ba_setup_sm__on_start,"ax",@progbits
	.global ba_setup_sm__on_start
ba_setup_sm__on_start:
L_8ed558:
	push_s r13
L_8ed55a:
	add r13,r0,0x20
L_8ed55e:
	stb_s r1,[r13,0x1d]
L_8ed560:
	stb_s r1,[r13,0x1c]
L_8ed562:
	stw r2,[r0, 0x42]
L_8ed566:
	stw r2,[r0, 0x40]
L_8ed56a:
	stb_s r3,[r13,0x1f]
L_8ed56c:
	stb_s r3,[r13,0x1e]
L_8ed56e:
	mov_s r0,0x0
L_8ed570:
	stb_s r0,[r13,0xc]
L_8ed572:
	j_s.d [blink]
L_8ed574:
	pop_s r13
L_8ed576:
	nop_s
