/* sm__inject_evt_b @ 0x8e5340, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.sm__inject_evt_b,"ax",@progbits
	.global sm__inject_evt_b
sm__inject_evt_b:
L_8e5340:
	mov_s r2,r1
L_8e5342:
	add_s r0,r0,0x28
L_8e5344:
	mov_s r1,0xb
L_8e5346:
	mov_s r3,0x0
L_8e5348:
	b.d L_8d6a1c
L_8e534c:
	mov_s r4,r3
L_8e534e:
	nop_s
