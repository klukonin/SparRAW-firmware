/* bi_manager__l1_entry_b @ 0x928948, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_manager.cpp
 * Зовут его: l1_task__entry
 * Зовёт сам: tail_ps_awake_peer__build_evt, uc_sysassert
 */
	.section .text.bi_manager__l1_entry_b,"ax",@progbits
	.global bi_manager__l1_entry_b
bi_manager__l1_entry_b:
	.global L_928948
L_928948:
	push_s r13
L_92894a:
	ld_s r1,[r0,0x38]
L_92894c:
	breq.d r1,0x0,L_92896c
L_928950:
	mov_s r13,blink
L_928952:
	breq r1,0x1,L_928980
L_928956:
	mov_s r2,0x1002b80
L_92895c:
	breq.d r1,0x2,L_92898c
L_928960:
	mov_s r0,blink
L_928962:
	mov_s r1,0x88
L_928964:
	b.d L_928990
L_928968:
	mov r3,0x91
	.global L_92896c
L_92896c:
	mov_s r0,blink
L_92896e:
	mov_s r2,0x1002b80
L_928974:
	mov r1,0x74
L_928978:
	b.d L_928990
L_92897c:
	mov r3,0x88
	.global L_928980
L_928980:
	bl.d L_92899c
L_928984:
	add r0,r0,0x20
L_928988:
	b L_928994
	.global L_92898c
L_92898c:
	mov_s r1,0x87
L_92898e:
	mov_s r3,0x8e
	.global L_928990
L_928990:
	bl L_925548
	.global L_928994
L_928994:
	mov_s blink,r13
L_928996:
	j_s.d [blink]
L_928998:
	pop_s r13
L_92899a:
	nop_s
