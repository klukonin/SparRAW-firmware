/* calib_mngr__schedule_scheme_step @ 0x8e498c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_calib_done, calib_engine__schedule_all_schemes
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x80023b, 0x800388
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_mngr__schedule_scheme_step
calib_mngr__schedule_scheme_step:
	.global L_8e498c
L_8e498c:
	push_s blink
L_8e498e:
	bl L_8c01dc
L_8e4992:
	mov_s r13,r0
L_8e4994:
	mov_s r15,r1
L_8e4996:
	brhs.d r0,0x6,L_8e49e4
L_8e499a:
	mov_s r16,r2
	.global L_8e499c
L_8e499c:
	ld_s r0,[r15]
L_8e499e:
	mov_s r1,0x804924
L_8e49a4:
	add2 r14,r1,r13
L_8e49a8:
	bbit0 r0,0x0,L_8e49f2
L_8e49ac:
	ldw_s r2,[r15,0x8]
L_8e49ae:
	breq_s r2,0,L_8e49f2
L_8e49b0:
	ld_s r0,[r14,0x8]
L_8e49b2:
	brne_s r0,0,L_8e49f6
L_8e49b4:
	mul64 r2,0x3e8
L_8e49b8:
	mov r4,mlo
L_8e49bc:
	breq r16,0x0,L_8e49c8
L_8e49c0:
	ldb_s r0,[gp,0xb7]
L_8e49c2:
	breq_s r0,0,L_8e49c8
L_8e49c4:
	ld.as r4,[gp,0x81]
	.global L_8e49c8
L_8e49c8:
	mov_s r0,0x1
L_8e49ca:
	add_s r1,r1,r13
L_8e49cc:
	stb_s r0,[r1]
L_8e49ce:
	mov_s r0,0x5680
L_8e49d4:
	mov_s r1,r13
L_8e49d6:
	mov_s r2,0x0
L_8e49d8:
	mov_s r3,r2
L_8e49da:
	mov_s r5,r2
L_8e49dc:
	bl.d L_8e0c0c
L_8e49e0:
	mov_s r6,r2
L_8e49e2:
	b_s L_8e49f4
	.global L_8e49e4
L_8e49e4:
	mov_s r0,blink
L_8e49e6:
	mov_s r1,0x120a
L_8e49ec:
	bl L_8c9b28
L_8e49f0:
	b_s L_8e499c
	.global L_8e49f2
L_8e49f2:
	mov_s r0,0x0
	.global L_8e49f4
L_8e49f4:
	st_s r0,[r14,0x8]
	.global L_8e49f6
L_8e49f6:
	b L_8c0244
L_8e49fa:
	nop_s
