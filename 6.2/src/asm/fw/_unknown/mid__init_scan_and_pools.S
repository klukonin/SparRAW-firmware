/* mid__init_scan_and_pools @ 0x8d9660, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mem_pool__init, mid__init_find_sm, radio_req__addr_of, scan_mngr__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__init_scan_and_pools
mid__init_scan_and_pools:
	.global L_8d9660
L_8d9660:
	push_s blink
L_8d9662:
	bl L_8c01e0
L_8d9666:
	mov_s r13,r0
L_8d9668:
	mov_s r15,r1
L_8d966a:
	st_s r1,[r0,0x4]
L_8d966c:
	mov_s r0,0x843158
L_8d9672:
	mov_s r14,0x0
L_8d9674:
	st_s r14,[r0]
L_8d9676:
	st_s r14,[r0,0x4]
L_8d9678:
	st_s r14,[r0,0x8]
L_8d967a:
	st_s r14,[r0,0xc]
L_8d967c:
	st_s r14,[r0,0x10]
L_8d967e:
	st_s r14,[r0,0x14]
L_8d9680:
	st_s r14,[r0,0x18]
L_8d9682:
	st_s r14,[r0,0x20]
L_8d9684:
	st_s r14,[r0,0x24]
L_8d9686:
	st_s r14,[r0,0x28]
L_8d9688:
	st_s r14,[r0,0x1c]
L_8d968a:
	st_s r14,[r0,0x2c]
L_8d968c:
	bl.d L_8f3698
L_8d9690:
	ldb_s r0,[r1,0x10]
L_8d9692:
	st_s r0,[r13,0x8]
L_8d9694:
	bl.d L_8f1cb8
L_8d9698:
	mov_s r1,r15
L_8d969a:
	ld_s r0,[r13,0x8]
L_8d969c:
	st_s r14,[r0,0x78]
L_8d969e:
	bl.d L_8d9588
L_8d96a2:
	add r0,r13,0xc
L_8d96a6:
	mov_s r1,0x805538
L_8d96ac:
	mov_s r0,0x805524
L_8d96b2:
	mov_s r2,0x4c
L_8d96b4:
	bl.d L_8c7cf8
L_8d96b8:
	mov_s r3,0x10
L_8d96ba:
	b L_8c024c
L_8d96be:
	nop_s
