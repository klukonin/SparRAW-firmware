/* MAINTAIN_SM__OPEN @ 0x8eb908, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAINTAIN_SM::OPEN BF Triggers
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__inject_event, fw_log__emit0, lm__get_cid, lm__get_mid_id, lmac_if_send_cmd_0x14, maintain_sm__clear_40_and_inject, mid_list__by_mid, process_expected_bf_results
 */
	.section .text.MAINTAIN_SM__OPEN,"ax",@progbits
	.global MAINTAIN_SM__OPEN
MAINTAIN_SM__OPEN:
L_8eb908:
	push_s blink
L_8eb90a:
	bl L_8c02b8
L_8eb90e:
	mov_s r14,r0
L_8eb910:
	ld_s r0,[r0,0x40]
L_8eb912:
	brne r0,0x0,L_8eb9a6
L_8eb916:
	bl.d L_8ca1a8
L_8eb91a:
	ld_s r0,[r14,0x2c]
L_8eb91c:
	bl.d L_8ca1b0
L_8eb920:
	mov_s r13,0x0
L_8eb922:
	add3 r0,r14,0xa
L_8eb926:
	mov_s r1,r13
L_8eb928:
	mov_s r2,r13
L_8eb92a:
	mov_s r3,r13
L_8eb92c:
	bl.d L_8d6a1c
L_8eb930:
	mov_s r4,r13
L_8eb932:
	ld_s r0,[r14,0x2c]
L_8eb934:
	mov_s r1,0x7
L_8eb936:
	mov_s r2,r13
L_8eb938:
	mov_s r3,r13
L_8eb93a:
	bl.d L_8d6a1c
L_8eb93e:
	mov_s r4,r13
L_8eb940:
	mov_s r0,r14
L_8eb942:
	bl.d L_8dd084
L_8eb946:
	ldb r1,[r14, 0x3d]
L_8eb94a:
	mov_s r2,0x1011f3c
L_8eb950:
	mov_s r0,r13
L_8eb952:
	bl.d L_8edfb0
L_8eb956:
	mov_s r1,0x2
L_8eb958:
	ld_s r0,[r14,0x30]
L_8eb95a:
	mov_s r15,0x1
L_8eb95c:
	cmp_s r0,0x0
L_8eb95e:
	mov_s r0,0x80345c
L_8eb964:
	ld_s r1,[r0,0xc]
L_8eb966:
	sub_s.ne r15,r15,r15
L_8eb968:
	cmp_s r1,0x0
L_8eb96a:
	mov r16,0x1
L_8eb96e:
	sub.ne r16,r16,r16
L_8eb972:
	cmp_s r1,0x0
L_8eb974:
	mov.ne r15,r13
L_8eb978:
	cmp_s r1,0x0
L_8eb97a:
	mov r17,0x1
L_8eb97e:
	sub.ne r17,r17,r17
L_8eb982:
	bl.d L_8c9d74
L_8eb986:
	ld_s r0,[r14,0x2c]
L_8eb988:
	mov_s r1,r16
L_8eb98a:
	extb_s r0,r0
L_8eb98c:
	mov_s r2,r15
L_8eb98e:
	mov_s r3,r17
L_8eb990:
	mov r4,r17
L_8eb994:
	bl.d L_8d8390
L_8eb998:
	mov r5,r17
L_8eb99c:
	ld_s r0,[gp,-0xdc]
L_8eb99e:
	st_s r0,[r14,0x38]
L_8eb9a0:
	bl.d L_8d6aec
L_8eb9a4:
	mov_s r0,r14
	.global L_8eb9a6
L_8eb9a6:
	b L_8c031c
L_8eb9aa:
	nop_s
