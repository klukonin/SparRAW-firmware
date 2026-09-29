/* discovery__inject_probe_evt @ 0x8e11b4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_handle_probe_req
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery__inject_probe_evt
discovery__inject_probe_evt:
	.global L_8e11b4
L_8e11b4:
	mov_s r2,r1
L_8e11b6:
	add r1,r0,0x1c
L_8e11ba:
	ld_s r3,[r0,0x14]
L_8e11bc:
	mov_s r0,r1
L_8e11be:
	mov_s r1,0x4
L_8e11c0:
	b.d L_8d9b6c
L_8e11c4:
	mov r4,0x0
