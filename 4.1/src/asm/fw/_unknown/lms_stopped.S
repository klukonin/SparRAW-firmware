/* lms_stopped @ 0x8edf18, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lms_stopped() DISC SM - spurious LMS Stop Done notification.
 * Зовёт сам: basic_sm__inject_event, fw_log__emit0
 */
	.section .text.lms_stopped,"ax",@progbits
	.global lms_stopped
lms_stopped:
L_8edf18:
	push_s blink
L_8edf1a:
	mov_s r3,r0
L_8edf1c:
	ld_s r0,[r0,0x30]
L_8edf1e:
	bbit0 r0,0x2,L_8edf46
L_8edf22:
	bic r0,r0,0xc
L_8edf26:
	bset_s r0,r0,0x3
L_8edf28:
	st_s r0,[r3,0x30]
L_8edf2a:
	ld_s r0,[r3,0x2c]
L_8edf2c:
	mov r4,0x2b04c
L_8edf34:
	ld_s r0,[r0,0x2c]
L_8edf36:
	mov_s r1,0x1
L_8edf38:
	add r0,r0,0xb0
L_8edf3c:
	mov_s r2,0x0
L_8edf3e:
	bl.d L_8d6a1c
L_8edf42:
	ldw_s r3,[r3,0x3a]
L_8edf44:
	b_s L_8edf54
	.global L_8edf46
L_8edf46:
	mov_s r2,0x100f918
L_8edf4c:
	mov_s r0,0xb
L_8edf4e:
	bl.d L_8edfb0
L_8edf52:
	mov_s r1,0x2
	.global L_8edf54
L_8edf54:
	pop_s blink
L_8edf56:
	j_s [blink]
