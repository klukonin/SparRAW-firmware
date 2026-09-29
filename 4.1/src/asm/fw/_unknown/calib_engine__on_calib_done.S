/* calib_engine__on_calib_done @ 0x8c4ad8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.calib_engine__on_calib_done,"ax",@progbits
	.global calib_engine__on_calib_done
calib_engine__on_calib_done:
L_8c4ad8:
	push_s blink
L_8c4ada:
	ld_s r2,[r0,0x50]
L_8c4adc:
	mov_s r1,r0
L_8c4ade:
	breq_s r2,0,L_8c4ae6
L_8c4ae0:
	ld_s r0,[r1,0x54]
L_8c4ae2:
	jl_s.d [r2]
L_8c4ae4:
	ld_s r1,[r1,0x58]
	.global L_8c4ae6
L_8c4ae6:
	pop_s blink
