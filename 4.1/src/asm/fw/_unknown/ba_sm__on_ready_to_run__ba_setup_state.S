/* ba_sm__on_ready_to_run__ba_setup_state @ 0x8e26f8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: ba_sm__vring_field7, basic_sm__inject_event
 */
	.section .text.ba_sm__on_ready_to_run__ba_setup_state,"ax",@progbits
	.global ba_sm__on_ready_to_run__ba_setup_state
ba_sm__on_ready_to_run__ba_setup_state:
L_8e26f8:
	push_s blink
L_8e26fa:
	bl.d L_8cab50
L_8e26fe:
	mov_s r1,r0
L_8e2700:
	breq r0,0x9,L_8e2714
L_8e2704:
	add r0,r1,0x2c
L_8e2708:
	mov_s r1,0x1
L_8e270a:
	mov_s r2,0x0
L_8e270c:
	mov_s r3,r2
L_8e270e:
	bl.d L_8d6a1c
L_8e2712:
	mov_s r4,r2
	.global L_8e2714
L_8e2714:
	pop_s blink
L_8e2716:
	j_s [blink]
