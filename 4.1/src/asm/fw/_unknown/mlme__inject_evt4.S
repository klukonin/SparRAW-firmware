/* mlme__inject_evt4 @ 0x8da480, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_notify
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.mlme__inject_evt4,"ax",@progbits
	.global mlme__inject_evt4
mlme__inject_evt4:
	.global L_8da480
L_8da480:
	add r0,r0,0xfc
L_8da484:
	mov_s r1,0x4
L_8da486:
	mov_s r2,0x0
L_8da488:
	mov_s r3,r2
L_8da48a:
	b.d L_8d6a1c
L_8da48e:
	mov_s r4,r2
