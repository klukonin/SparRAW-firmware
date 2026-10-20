/* sniffer_mode_step @ 0x8f1844, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_cfg_rx_chain
 * Зовёт сам: __ld_r13_ret, dma_mgr__configure_ring, get_g_8001dc, sniffer__init_pool, tx_queue_mgr__create_queue, vring_schd__add_sniffer_vring
 * Глобалы (через gp): 0x800454
 */
	.section .text.sniffer_mode_step,"ax",@progbits
	.global sniffer_mode_step
sniffer_mode_step:
	.global L_8f1844
L_8f1844:
	push_s blink
L_8f1846:
	push_s r13
L_8f1848:
	bl.d L_8cabe0
L_8f184c:
	sub_s sp,sp,0x4
L_8f184e:
	mov_s r13,0x0
L_8f1850:
	breq_s r0,0,L_8f18a2
L_8f1852:
	mov_s r1,0x5
L_8f1854:
	st_s r1,[sp,0x0]
L_8f1856:
	mov_s r1,r13
L_8f1858:
	mov_s r2,r13
L_8f185a:
	mov_s r3,0x40
L_8f185c:
	mov r4,0x2000
L_8f1864:
	mov r5,0x2800
L_8f186c:
	mov r6,0x900
L_8f1874:
	bl.d L_8d68d8
L_8f1878:
	mov r7,0x1
L_8f187c:
	bl L_8d5a8c
L_8f1880:
	mov_s r0,r13
L_8f1882:
	mov_s r1,0x0
L_8f1884:
	bset_s r1,r1,0xd
L_8f1886:
	mov_s r2,0x5
L_8f1888:
	bl.d L_8c2568
L_8f188c:
	asl_s r2,r2,0xb
L_8f188e:
	mov_s r0,r13
L_8f1890:
	mov_s r1,r13
L_8f1892:
	mov_s r2,r13
L_8f1894:
	mov_s r3,r13
L_8f1896:
	mov_s r4,r13
L_8f1898:
	mov_s r5,r13
L_8f189a:
	mov_s r6,r13
L_8f189c:
	bl.d L_8c611c
L_8f18a0:
	mov_s r7,r13
	.global L_8f18a2
L_8f18a2:
	mov_s r0,0x1
L_8f18a4:
	mov_s r1,0x0
L_8f18a6:
	mov_s r2,r1
L_8f18a8:
	mov_s r3,r1
L_8f18aa:
	mov_s r4,r1
L_8f18ac:
	mov_s r5,r1
L_8f18ae:
	mov_s r6,r1
L_8f18b0:
	bl.d L_8c611c
L_8f18b4:
	mov_s r7,r1
L_8f18b6:
	mov_s r0,0x1
L_8f18b8:
	mov_s r1,0x9
L_8f18ba:
	asl_s r1,r1,0xb
L_8f18bc:
	mov_s r2,0x0
L_8f18be:
	bl.d L_8c2568
L_8f18c2:
	bset_s r2,r2,0xb
L_8f18c4:
	st.as r13,[gp,0xb9]
L_8f18c8:
	b.d L_8c033c
