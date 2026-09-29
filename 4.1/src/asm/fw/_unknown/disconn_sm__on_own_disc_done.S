/* disconn_sm__on_own_disc_done @ 0x8eb104, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.disconn_sm__on_own_disc_done,"ax",@progbits
	.global disconn_sm__on_own_disc_done
disconn_sm__on_own_disc_done:
L_8eb104:
	mov_s r3,r0
L_8eb106:
	mov_s r0,0x0
L_8eb108:
	st_s r0,[r3,0x3c]
L_8eb10a:
	ld_s r0,[r3,0x2c]
L_8eb10c:
	mov_s r1,0x9
L_8eb10e:
	ldb r2,[r3, 0x38]
L_8eb112:
	ldw_s r3,[r3,0x3a]
L_8eb114:
	b.d L_8d6a1c
L_8eb118:
	mov r4,0x0
