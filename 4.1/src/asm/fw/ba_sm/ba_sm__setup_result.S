/* ba_sm__setup_result @ 0x8c3950, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BA Setup succeed: WSIZE %d. TIMEOUT: %d, AMSDU: %d
 *   ba_sm.cpp
 *   BA Setup failed: reason %d (wsize %d).
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.ba_sm__setup_result,"ax",@progbits
	.global ba_sm__setup_result
ba_sm__setup_result:
L_8c3950:
	push_s blink
L_8c3952:
	bl L_8c02b4
L_8c3956:
	mov_s r13,r0
L_8c3958:
	mov.f r14,r1
L_8c395c:
	mov_s r16,r2
L_8c395e:
	mov_s r17,r3
L_8c3960:
	bne_s L_8c39b2
L_8c3962:
	ldb r18,[r13, 0x6b]
L_8c3966:
	mov_s r2,0x10101bc
L_8c396c:
	mov_s r0,0xb
L_8c396e:
	mov_s r1,0x2
L_8c3970:
	mov_s r3,r16
L_8c3972:
	mov r4,r17
L_8c3976:
	bl.d L_8ee034
L_8c397a:
	mov r5,r18
L_8c397e:
	breq r16,0x0,L_8c399a
	.global L_8c3982
L_8c3982:
	ld r0,[r13, 0xac]
L_8c3986:
	ld r3,[r0, 0xd4]
L_8c398a:
	extw r2,r17
L_8c398e:
	ld_s r13,[r3,0x18]
L_8c3990:
	extb r1,r16
L_8c3994:
	jl_s.d [r13]
L_8c3996:
	mov_s r3,r18
L_8c3998:
	b_s L_8c39d2
	.global L_8c399a
L_8c399a:
	mov_s r0,blink
L_8c399c:
	mov_s r2,0x10101f0
L_8c39a2:
	mov_s r1,0x133e
L_8c39a8:
	bl.d L_8c82c0
L_8c39ac:
	mov r3,0x101
L_8c39b0:
	b_s L_8c3982
	.global L_8c39b2
L_8c39b2:
	mov_s r2,0x10101fc
L_8c39b8:
	mov_s r0,0xb
L_8c39ba:
	mov_s r1,0x2
L_8c39bc:
	mov_s r3,r14
L_8c39be:
	bl.d L_8edff8
L_8c39c2:
	mov r4,r16
L_8c39c6:
	ld r0,[r13, 0xac]
L_8c39ca:
	ld r1,[r0, 0xd4]
L_8c39ce:
	ld_s r1,[r1,0x1c]
L_8c39d0:
	jl_s [r1]
	.global L_8c39d2
L_8c39d2:
	.byte 0x45,0x01
