/* pcie_device_power_sm__pcie_traffic_resume_req @ 0x8e05ec, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_16
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, dbi_write, hwd_pcie__is_ep_under_serdes, hwd_pcie__read_8825c0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_device_power_sm__pcie_traffic_resume_req
pcie_device_power_sm__pcie_traffic_resume_req:
	.global L_8e05ec
L_8e05ec:
	push_s blink
L_8e05ee:
	bl L_8c01e4
L_8e05f2:
	bl.d L_8d141c
L_8e05f6:
	sub_s sp,sp,0x4
L_8e05f8:
	bl.d L_8d1470
L_8e05fc:
	mov_s r13,r0
L_8e05fe:
	mov.f r14,r0
L_8e0602:
	bne_s L_8e0622
L_8e0604:
	mov_s r2,0x0
L_8e0606:
	st_s r2,[sp,0x0]
L_8e0608:
	mov_s r0,0x60
L_8e060a:
	mov_s r1,0x700d
L_8e0610:
	mov_s r3,r2
L_8e0612:
	mov_s r4,r2
L_8e0614:
	mov_s r5,r2
L_8e0616:
	mov r6,0x1
L_8e061a:
	bl.d L_8c8338
L_8e061e:
	mov r7,r6
	.global L_8e0622
L_8e0622:
	bbit0 r13,0x0,L_8e0640
L_8e0626:
	mov_s r3,0x0
L_8e0628:
	st_s r3,[sp,0x0]
L_8e062a:
	mov_s r0,0x60
L_8e062c:
	mov_s r1,0x700d
L_8e0632:
	mov_s r2,0x1
L_8e0634:
	mov_s r4,r3
L_8e0636:
	mov_s r5,r3
L_8e0638:
	mov_s r6,r2
L_8e063a:
	bl.d L_8c8338
L_8e063e:
	mov_s r7,r2
	.global L_8e0640
L_8e0640:
	bbit0 r13,0x1,L_8e0662
L_8e0644:
	mov_s r3,0x0
L_8e0646:
	st_s r3,[sp,0x0]
L_8e0648:
	mov_s r0,0x60
L_8e064a:
	mov_s r1,0x700d
L_8e0650:
	mov_s r2,0x2
L_8e0652:
	mov_s r4,r3
L_8e0654:
	mov_s r5,r3
L_8e0656:
	mov r6,0x1
L_8e065a:
	bl.d L_8c8338
L_8e065e:
	mov r7,r6
	.global L_8e0662
L_8e0662:
	bbit0 r13,0x2,L_8e0686
L_8e0666:
	mov_s r2,0x0
L_8e0668:
	st_s r2,[sp,0x0]
L_8e066a:
	mov_s r0,0x60
L_8e066c:
	mov_s r1,0x700d
L_8e0672:
	mov_s r3,r2
L_8e0674:
	mov r4,0x1
L_8e0678:
	mov_s r5,r2
L_8e067a:
	mov r6,r4
L_8e067e:
	bl.d L_8c8338
L_8e0682:
	mov r7,r4
	.global L_8e0686
L_8e0686:
	bbit0 r13,0x3,L_8e06ac
L_8e068a:
	mov_s r2,0x0
L_8e068c:
	st_s r2,[sp,0x0]
L_8e068e:
	mov_s r0,0x60
L_8e0690:
	mov_s r1,0x700d
L_8e0696:
	mov_s r3,r2
L_8e0698:
	mov r4,0x1
L_8e069c:
	mov r5,r4
L_8e06a0:
	mov r6,r4
L_8e06a4:
	bl.d L_8c8338
L_8e06a8:
	mov r7,r4
	.global L_8e06ac
L_8e06ac:
	brne_s r14,0,L_8e06cc
L_8e06ae:
	mov_s r2,0x0
L_8e06b0:
	st_s r2,[sp,0x0]
L_8e06b2:
	mov_s r0,0x64
L_8e06b4:
	mov_s r1,0x1ae9
L_8e06ba:
	mov_s r3,r2
L_8e06bc:
	mov_s r4,r2
L_8e06be:
	mov_s r5,r2
L_8e06c0:
	mov r6,0x1
L_8e06c4:
	bl.d L_8c8338
L_8e06c8:
	mov r7,r6
	.global L_8e06cc
L_8e06cc:
	bbit0 r13,0x0,L_8e06ea
L_8e06d0:
	mov_s r3,0x0
L_8e06d2:
	st_s r3,[sp,0x0]
L_8e06d4:
	mov_s r0,0x64
L_8e06d6:
	mov_s r1,0x1ae9
L_8e06dc:
	mov_s r2,0x1
L_8e06de:
	mov_s r4,r3
L_8e06e0:
	mov_s r5,r3
L_8e06e2:
	mov_s r6,r2
L_8e06e4:
	bl.d L_8c8338
L_8e06e8:
	mov_s r7,r2
	.global L_8e06ea
L_8e06ea:
	bbit0 r13,0x1,L_8e070c
L_8e06ee:
	mov_s r3,0x0
L_8e06f0:
	st_s r3,[sp,0x0]
L_8e06f2:
	mov_s r0,0x64
L_8e06f4:
	mov_s r1,0x1ae9
L_8e06fa:
	mov_s r2,0x2
L_8e06fc:
	mov_s r4,r3
L_8e06fe:
	mov_s r5,r3
L_8e0700:
	mov r6,0x1
L_8e0704:
	bl.d L_8c8338
L_8e0708:
	mov r7,r6
	.global L_8e070c
L_8e070c:
	bbit0 r13,0x2,L_8e0730
L_8e0710:
	mov_s r2,0x0
L_8e0712:
	st_s r2,[sp,0x0]
L_8e0714:
	mov_s r0,0x64
L_8e0716:
	mov_s r1,0x1ae9
L_8e071c:
	mov_s r3,r2
L_8e071e:
	mov r4,0x1
L_8e0722:
	mov_s r5,r2
L_8e0724:
	mov r6,r4
L_8e0728:
	bl.d L_8c8338
L_8e072c:
	mov r7,r4
	.global L_8e0730
L_8e0730:
	bbit0 r13,0x3,L_8e0756
L_8e0734:
	mov_s r2,0x0
L_8e0736:
	st_s r2,[sp,0x0]
L_8e0738:
	mov_s r0,0x64
L_8e073a:
	mov_s r1,0x1ae9
L_8e0740:
	mov_s r3,r2
L_8e0742:
	mov r4,0x1
L_8e0746:
	mov r5,r4
L_8e074a:
	mov r6,r4
L_8e074e:
	bl.d L_8c8338
L_8e0752:
	mov r7,r4
	.global L_8e0756
L_8e0756:
	b.d L_8c0254
L_8e075a:
	add_s sp,sp,0x4
