/* tx_macq_api_step @ 0x8d67cc, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_oob_pools
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, tx_macq__config_ring_params, tx_macq__setup
 */
	.section .text.tx_macq_api_step,"ax",@progbits
	.global tx_macq_api_step
tx_macq_api_step:
	.global L_8d67cc
L_8d67cc:
	push_s blink
L_8d67ce:
	bl.d L_8c02c4
L_8d67d2:
	mov_s r0,0x1e
L_8d67d4:
	mov_s r13,0x8062f4
L_8d67da:
	stb r0,[r13, 0xf0]
L_8d67de:
	add3 r0,r13,0x1e
L_8d67e2:
	mov r1,0x1ca
L_8d67e6:
	mov_s r2,0x8
L_8d67e8:
	mov_s r3,0x50aa
L_8d67ee:
	mov r4,0x8a
L_8d67f2:
	bl.d L_8de5d8
L_8d67f6:
	mov r5,0x200
L_8d67fa:
	mov_s r14,0x801508
L_8d6800:
	ld_s r3,[r14,0x74]
L_8d6802:
	mov_s r2,0x1
L_8d6804:
	cmp_s r3,0x0
L_8d6806:
	sub_s.ne r2,r2,r2
L_8d6808:
	cmp_s r3,0x1
L_8d680a:
	mov_s r3,0x1
L_8d680c:
	sub_s.ne r3,r3,r3
L_8d680e:
	add3 r0,r13,0x1e
L_8d6812:
	mov_s r1,0x9
L_8d6814:
	mov r4,0x7
L_8d6818:
	mov r5,0x0
L_8d681c:
	mov r6,r5
L_8d6820:
	bl.d L_8d63fc
L_8d6824:
	mov r7,r5
L_8d6828:
	mov_s r0,0x1a
L_8d682a:
	stb r0,[r13, 0xd0]
L_8d682e:
	add3 r0,r13,0x1a
L_8d6832:
	mov r1,0x1c2
L_8d6836:
	mov_s r2,0x8
L_8d6838:
	mov_s r3,0x5
L_8d683a:
	asl_s r3,r3,0xc
L_8d683c:
	mov r4,0xaa
L_8d6840:
	bl.d L_8de5d8
L_8d6844:
	mov r5,0x500
L_8d6848:
	ld_s r3,[r14,0x54]
L_8d684a:
	mov_s r2,0x1
L_8d684c:
	cmp_s r3,0x0
L_8d684e:
	sub_s.ne r2,r2,r2
L_8d6850:
	cmp_s r3,0x1
L_8d6852:
	mov_s r3,0x1
L_8d6854:
	sub_s.ne r3,r3,r3
L_8d6856:
	add3 r0,r13,0x1a
L_8d685a:
	mov_s r1,0x8
L_8d685c:
	mov r4,0x7
L_8d6860:
	mov r5,0x0
L_8d6864:
	mov r6,r5
L_8d6868:
	bl.d L_8d63fc
L_8d686c:
	mov r7,r5
L_8d6870:
	b L_8c0334
