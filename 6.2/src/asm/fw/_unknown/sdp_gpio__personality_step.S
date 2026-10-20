/* sdp_gpio__personality_step @ 0x8f1920, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::sdp_init() the following sdp port has invalid enabled_at_personality field: %d
 * Зовут его: sdp_gpio__boot_init
 * Зовёт сам: fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp_gpio__personality_step
sdp_gpio__personality_step:
	.global L_8f1920
L_8f1920:
	push_s blink
L_8f1922:
	mov_s r1,0x800c34
L_8f1928:
	ld.as r2,[r1,r0]
L_8f192c:
	lsr r0,r2,0xd
L_8f1930:
	bmsk.f r0,r0,0x1
L_8f1934:
	beq_s L_8f195e
L_8f1936:
	breq r0,0x1,L_8f196a
L_8f193a:
	breq r0,0x2,L_8f197a
L_8f193e:
	breq r0,0x3,L_8f1976
L_8f1942:
	mov_s r1,0x1008ed0
L_8f1948:
	mov_s r0,0x0
L_8f194a:
	bl.d L_8dcc10
L_8f194e:
	bmsk_s r2,r2,0x4
L_8f1950:
	mov_s r0,blink
L_8f1952:
	mov_s r1,0x1311
L_8f1958:
	bl L_8c9b28
L_8f195c:
	b_s L_8f197a
	.global L_8f195e
L_8f195e:
	mov_s r0,0x880a3c
L_8f1964:
	ld_s r0,[r0,0x7c]
L_8f1966:
	breq_s r0,0,L_8f197a
L_8f1968:
	b_s L_8f1976
	.global L_8f196a
L_8f196a:
	mov_s r0,0x880a3c
L_8f1970:
	ld_s r0,[r0,0x7c]
L_8f1972:
	breq r0,0x1,L_8f197a
	.global L_8f1976
L_8f1976:
	mov_s r0,0x0
L_8f1978:
	b_s L_8f197c
	.global L_8f197a
L_8f197a:
	mov_s r0,0x1
	.global L_8f197c
L_8f197c:
	pop_s blink
L_8f197e:
	j_s [blink]
