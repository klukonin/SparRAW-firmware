/* uc__init_globals @ 0x92094c, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words_uc, uc_vector_01
 * Глобалы (через gp): 0x8005ac
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc__init_globals
uc__init_globals:
	.global L_92094c
L_92094c:
	push_s blink
L_92094e:
	push_s r13
L_920950:
	mov_s r13,r0
L_920952:
	bl.d L_920a84
L_920956:
	mov_s r1,0x28
L_920958:
	mov_s r0,0x0
L_92095a:
	add_s r13,r13,0x20
L_92095c:
	stb_s r0,[r13,0x8]
L_92095e:
	stb_s r0,[r13,0x9]
L_920960:
	mov_s r0,0xff
L_920962:
	b.d L_9202ac
L_920966:
	stb_s r0,[r13,0xa]
L_920968:
	mov_s r0,0x8006b4
L_92096e:
	ldb_s r1,[r0,0x3]
L_920970:
	mov_s r0,0x800824
L_920976:
	j_s.d [blink]
L_920978:
	stb_s r1,[r0,0x4]
L_92097a:
	nop_s
L_92097c:
	mov_s r0,0x801be8
L_920982:
	b.d L_92094c
L_920986:
	mov_s r1,0x0
L_920988:
	mov_s r0,0x803134
L_92098e:
	b.d L_920948
L_920992:
	mov_s r1,0x0
L_920994:
	ld.as r1,[gp,0x21]
L_920998:
	mov_s r0,0x801aec
L_92099e:
	j_s.d [blink]
L_9209a0:
	st_s r1,[r0]
L_9209a2:
	nop_s
L_9209a4:
	mov_s r1,0x802470
L_9209aa:
	mov_s r0,0x800730
L_9209b0:
	j_s.d [blink]
L_9209b2:
	st_s r0,[r1,0x44]
L_9209b4:
	push_s blink
L_9209b6:
	push_s r13
L_9209b8:
	mov_s r1,0x800724
L_9209be:
	ld_s r0,[r1]
L_9209c0:
	brne_s r0,0,L_9209dc
L_9209c2:
	mov_s r0,0x1
L_9209c4:
	st_s r0,[r1]
L_9209c6:
	mov_s r1,0x8017b8
L_9209cc:
	ld_s r13,[r1,0x8]
L_9209ce:
	mov_s r0,0x0
L_9209d0:
	st_s r0,[r1,0x8]
L_9209d2:
	breq_s r13,0,L_9209dc
	.global L_9209d4
L_9209d4:
	ld_s r0,[r13,0x4]
L_9209d6:
	jl_s [r0]
L_9209d8:
	ld_s r13,[r13,0x8]
L_9209da:
	brne_s r13,0,L_9209d4
	.global L_9209dc
L_9209dc:
	b L_9202ac
