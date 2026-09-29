/* discovery__inject_probe_evt @ 0x8dd040, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_handle_probe_req
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.discovery__inject_probe_evt,"ax",@progbits
	.global discovery__inject_probe_evt
discovery__inject_probe_evt:
	.global L_8dd040
L_8dd040:
	mov_s r2,r1
L_8dd042:
	add r1,r0,0x1c
L_8dd046:
	ld_s r3,[r0,0x14]
L_8dd048:
	mov_s r0,r1
L_8dd04a:
	mov_s r1,0x4
L_8dd04c:
	b.d L_8d6a1c
L_8dd050:
	mov r4,0x0
